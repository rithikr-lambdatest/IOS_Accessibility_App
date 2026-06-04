import SwiftUI
import UIKit

struct ImagesWithTextView: View {

    // MARK: - Violation test-case data

    private struct ImageTextViolation {
        let id: String          // accessibility identifier
        let title: String
        let imageName: String
        var label: String? = nil
    }

    private static let violations: [ImageTextViolation] = [
        // Images of text + accessibilityLabel variants
        .init(id: "v01_image_text_no_label", title: "V-01: No Label", imageName: "textImage1"),
        .init(id: "v02_image_text_matching_label", title: "V-02: Matching Label", imageName: "textImage2", label: "Transparency"),
        .init(id: "v03_image_text_mismatched_label", title: "V-03: Mismatched Label", imageName: "textImage4", label: "Watch on a strap"),
        // Multilingual text-in-image samples
        .init(id: "v04_image_text_arabic", title: "V-04: Arabic", imageName: "arabicText"),
        .init(id: "v05_image_text_argentina", title: "V-05: Argentina / Spanish", imageName: "argentinaText"),
        .init(id: "v06_image_text_chinese", title: "V-06: Chinese (CJK)", imageName: "chineseText"),
        .init(id: "v07_image_text_german", title: "V-07: German", imageName: "germanText"),
        .init(id: "v08_image_text_hindi", title: "V-08: Hindi (Devanagari)", imageName: "hindiText"),
        .init(id: "v09_image_text_hindi_english", title: "V-09: Hindi + English (mixed scripts)", imageName: "hindiEnglishText"),
        .init(id: "v10_image_text_japanese", title: "V-10: Japanese (CJK)", imageName: "japaneseText"),
        .init(id: "v11_image_text_korean", title: "V-11: Korean (CJK)", imageName: "koreanText"),
        .init(id: "v12_image_text_polish", title: "V-12: Polish", imageName: "polishText"),
        .init(id: "v13_image_text_russian", title: "V-13: Russian (Cyrillic)", imageName: "russianText"),
        .init(id: "v14_image_text_spanish", title: "V-14: Spanish (Latin)", imageName: "spanishText"),
        .init(id: "v15_image_text_spanish2", title: "V-15: Spanish (second sample)", imageName: "spanishText2"),
        .init(id: "v16_image_text_urdu", title: "V-16: Urdu (Arabic script)", imageName: "urduText"),
        // Banner / CTA-style images of text
        .init(id: "v17_image_text_sale_banner", title: "V-17: Sale Banner", imageName: "saleBanner"),
        .init(id: "v18_image_text_buy_now_button", title: "V-18: Buy Now Button", imageName: "buyNowButton"),
        .init(id: "v19_image_text_welcome_hero", title: "V-19: Welcome Hero", imageName: "welcomeHero"),
        .init(id: "v20_image_text_price_tag", title: "V-20: Price Tag", imageName: "priceTag"),
        .init(id: "v21_image_text_new_badge", title: "V-21: New Badge", imageName: "newBadge"),
        .init(id: "v22_image_text_section_header", title: "V-22: Section Header", imageName: "sectionHeader"),
        .init(id: "v23_image_text_subscribe_cta", title: "V-23: Subscribe Cta", imageName: "subscribeCta"),
        .init(id: "v24_image_text_footer_text", title: "V-24: Footer Text", imageName: "footerText"),
        .init(id: "v25_image_text_notification_banner", title: "V-25: Notification Banner", imageName: "notificationBanner"),
        .init(id: "v26_image_text_download_banner", title: "V-26: Download Banner", imageName: "downloadBanner"),
        .init(id: "v27_image_text_login_button", title: "V-27: Login Button", imageName: "loginButton"),
        .init(id: "v28_image_text_offer_card", title: "V-28: Offer Card", imageName: "offerCard"),
        .init(id: "v29_image_text_tab_label", title: "V-29: Tab Label", imageName: "tabLabel"),
        .init(id: "v30_image_text_error_message", title: "V-30: Error Message", imageName: "errorMessage"),
        .init(id: "v31_image_text_quote_card", title: "V-31: Quote Card", imageName: "quoteCard"),
        .init(id: "v32_image_text_signup_button", title: "V-32: Signup Button", imageName: "signupButton"),
        .init(id: "v33_image_text_flash_deal", title: "V-33: Flash Deal", imageName: "flashDeal"),
        .init(id: "v34_image_text_coupon_code", title: "V-34: Coupon Code", imageName: "couponCode"),
        .init(id: "v35_image_text_free_shipping", title: "V-35: Free Shipping", imageName: "freeShipping"),
        .init(id: "v36_image_text_contact_us", title: "V-36: Contact Us", imageName: "contactUs"),
        .init(id: "v37_image_text_rate_us", title: "V-37: Rate Us", imageName: "rateUs"),
        .init(id: "v38_image_text_out_of_stock", title: "V-38: Out Of Stock", imageName: "outOfStock"),
        .init(id: "v39_image_text_membership_banner", title: "V-39: Membership Banner", imageName: "membershipBanner"),
        .init(id: "v40_image_text_search_placeholder", title: "V-40: Search Placeholder", imageName: "searchPlaceholder"),
        .init(id: "v41_image_text_cashback_offer", title: "V-41: Cashback Offer", imageName: "cashbackOffer"),
        .init(id: "v42_image_text_cookie_consent", title: "V-42: Cookie Consent", imageName: "cookieConsent"),
        .init(id: "v43_image_text_feature_highlight", title: "V-43: Feature Highlight", imageName: "featureHighlight"),
        .init(id: "v44_image_text_referral_banner", title: "V-44: Referral Banner", imageName: "referralBanner"),
        .init(id: "v45_image_text_warranty_badge", title: "V-45: Warranty Badge", imageName: "warrantyBadge"),
        .init(id: "v46_image_text_coming_soon", title: "V-46: Coming Soon", imageName: "comingSoon"),
        // E-commerce product images with readable text in pixels
        .init(id: "v47_image_text_garbage_bags_pack", title: "V-47: Product Packaging (Garbage Bags)", imageName: "garbageBagsPack"),
        .init(id: "v48_image_text_smartwatch_face", title: "V-48: Smartwatch Screen Text", imageName: "smartwatchFace"),
        .init(id: "v49_image_text_sentence_search_game", title: "V-49: Game Box Packaging", imageName: "sentenceSearchGame"),
        .init(id: "v50_image_text_book_indian_millennials", title: "V-50: Book Cover — Indian Millennials", imageName: "bookIndianMillennials"),
        .init(id: "v51_image_text_book_tubewell_house", title: "V-51: Book Cover — The Tubewell House", imageName: "bookTubewellHouse"),
        .init(id: "v52_image_text_book_ikigai", title: "V-52: Book Cover — Ikigai", imageName: "bookIkigai"),
        .init(id: "v53_image_text_book_final_experiment", title: "V-53: Book Cover — The Final Experiment", imageName: "bookFinalExperiment"),
        .init(id: "v54_image_text_surface_cleaner_can", title: "V-54: Cleaner Bottle Label", imageName: "surfaceCleanerCan"),
        .init(id: "v55_image_text_every_space_infographic", title: "V-55: Product Infographic (Every Space)", imageName: "everySpaceInfographic")
    ]

    // One labelled image cell, two of which sit side by side per row
    @ViewBuilder
    private func violationCell(_ violation: ImageTextViolation) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(violation.title)
                .font(.caption)
                .fontWeight(.semibold)

            if let label = violation.label {
                Image(violation.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 140)
                    .accessibilityLabel(label)
                    .accessibilityIdentifier(violation.id)
            } else {
                Image(violation.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 140)
                    .accessibilityIdentifier(violation.id)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Step scrolling (floating up/down arrows)

    // Scroll by roughly one screen-height per tap
    private static let scrollStepHeight: CGFloat = 600

    // Holds a reference to the UIScrollView backing the SwiftUI ScrollView,
    // so the arrows can drive contentOffset directly (reliable pixel scrolling).
    private final class ScrollViewHolder: ObservableObject {
        weak var scrollView: UIScrollView?
    }

    @StateObject private var scrollViewHolder = ScrollViewHolder()

    // Invisible helper embedded in the scroll content; walks up the UIKit
    // hierarchy to find the enclosing UIScrollView.
    private struct ScrollViewGrabber: UIViewRepresentable {
        let holder: ScrollViewHolder

        private static func findScrollView(from view: UIView?) -> UIScrollView? {
            var parent = view?.superview
            while let current = parent {
                if let scrollView = current as? UIScrollView {
                    return scrollView
                }
                parent = current.superview
            }
            return nil
        }

        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            view.isUserInteractionEnabled = false
            DispatchQueue.main.async { [weak view, weak holder] in
                holder?.scrollView = Self.findScrollView(from: view)
            }
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            DispatchQueue.main.async { [weak uiView, weak holder] in
                guard let holder, holder.scrollView == nil else { return }
                holder.scrollView = Self.findScrollView(from: uiView)
            }
        }
    }

    private func stepScroll(by delta: CGFloat) {
        guard let scrollView = scrollViewHolder.scrollView else { return }
        let minOffset = -scrollView.adjustedContentInset.top
        let maxOffset = max(
            minOffset,
            scrollView.contentSize.height
                + scrollView.adjustedContentInset.bottom
                - scrollView.bounds.height
        )
        let target = min(
            max(scrollView.contentOffset.y + delta * Self.scrollStepHeight, minOffset),
            maxOffset
        )
        scrollView.setContentOffset(CGPoint(x: 0, y: target), animated: true)
    }

    // 56pt buttons with 16pt spacing so the touch targets stay compliant
    private var scrollArrows: some View {
        VStack(spacing: 16) {
            Button {
                stepScroll(by: -1)
            } label: {
                Image(systemName: "chevron.up")
                    .font(.title2)
                    .frame(width: 56, height: 56)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .accessibilityLabel("Scroll up")
            .accessibilityIdentifier("scroll_up_button")

            Button {
                stepScroll(by: 1)
            } label: {
                Image(systemName: "chevron.down")
                    .font(.title2)
                    .frame(width: 56, height: 56)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
            .accessibilityLabel("Scroll down")
            .accessibilityIdentifier("scroll_down_button")
        }
        .padding(16)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Images of Text — image-in-text")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Fails when an image renders at least one readable word in its pixels AND the image does not qualify for a WCAG 1.4.5 exception. Exceptions: brand logo / wordmark, icon glyph, chart or data viz, scanned document, plain shape, photograph without rendered text, decorative artwork, or hidden / off-screen element. WCAG 1.4.5 (AA), Severity Serious.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Text("Key: an `accessibilityLabel` does NOT satisfy this rule — the violation is the embedding, not the missing label. Missing labels are a separate rule.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding(8)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(6)

                    Divider()

                    // MARK: - Violation Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Violation Test Cases — Image has text + no exception")
                            .font(.headline)
                            .foregroundColor(.red)

                        // V-01 .. V-55: images of text — two images per row
                        ForEach(Array(stride(from: 0, to: Self.violations.count, by: 2)), id: \.self) { index in
                            HStack(alignment: .top, spacing: 12) {
                                violationCell(Self.violations[index])
                                if index + 1 < Self.violations.count {
                                    violationCell(Self.violations[index + 1])
                                } else {
                                    Color.clear
                                        .frame(maxWidth: .infinity)
                                }
                            }

                            Divider()
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)

                    // MARK: - Pass Test Cases
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Pass Test Cases — Exception applies, no text, or hidden")
                            .font(.headline)
                            .foregroundColor(Color(red: 0, green: 0.5, blue: 0))

                        // P-01: Photograph without text
                        Group {
                            Text("P-01: Photograph Without Rendered Text")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("wooden_dice")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityLabel("Four wooden dice on a dark surface")
                                .accessibilityIdentifier("p01_photo_no_text")

                        }

                        Divider()

                        // P-02: Brand logos / wordmarks exception
                        Group {
                            Text("P-02: Brand Logos / Wordmarks (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack(alignment: .center, spacing: 16) {
                                Image("chanel")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 60)
                                Image("nike")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 60)
                                Image("pepsi")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 60)
                                Image("testmuLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 60)
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("p02_brand_logos")

                        }

                        Divider()

                        // P-03: Icon glyph exception
                        Group {
                            Text("P-03: Icon Glyphs (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack(spacing: 20) {
                                Image("bin")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                Image("camera")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                Image("folder")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("p03_icon_glyphs")

                        }

                        Divider()

                        // P-04: Plain shape exception
                        Group {
                            Text("P-04: Plain Shape (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            HStack(spacing: 10) {
                                Image("greenSwatch")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                Image("purpleSwatch")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                                Image("yellowSwatch")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 60)
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("p04_plain_shapes")

                        }

                        Divider()

                        // P-05: Decorative artwork with incidental text
                        Group {
                            Text("P-05: Decorative Artwork with Incidental Text (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("decorative")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 280)
                                .accessibilityIdentifier("p05_decorative_artwork")

                        }

                        Divider()

                        // P-06: Image of text hidden — silently dropped
                        Group {
                            Text("P-06: Image of Text — Hidden (Silently Dropped)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("learnEnglish")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 120)
                                .accessibilityHidden(true)
                                .accessibilityIdentifier("p06_image_text_hidden")

                        }

                        Divider()

                        // P-07: Chart / data viz exception
                        Group {
                            Text("P-07: Chart / Data Visualisation (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    Image("barChart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 100)
                                    Image("lineChart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 100)
                                }
                                HStack(spacing: 12) {
                                    Image("pieChart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 100)
                                    Image("pointChart")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 100)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("p07_charts")

                        }

                        Divider()

                        // P-08: Scanned document / receipt exception
                        Group {
                            Text("P-08: Scanned Document / Receipt (Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            VStack(spacing: 12) {
                                HStack(spacing: 12) {
                                    Image("receipt1")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 140)
                                    Image("receipt2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 140)
                                }
                                HStack(spacing: 12) {
                                    Image("scannedDoc")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 140)
                                    Image("scannedDoc2")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: 140)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .accessibilityIdentifier("p08_scanned_docs")

                        }

                        Divider()

                        // P-09: Brand Logo (Brand Logo)
                        Group {
                            Text("P-09: Brand Logo (Brand Logo Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("brandLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p09_brand_logo")
                        }

                        Divider()

                        // P-10: Gradient Bg (Plain Shape)
                        Group {
                            Text("P-10: Gradient Bg (Plain Shape Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("gradientBg")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p10_gradient_bg")
                        }

                        Divider()

                        // P-11: Placeholder (Plain Shape)
                        Group {
                            Text("P-11: Placeholder (Plain Shape Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p11_placeholder")
                        }

                        Divider()

                        // P-12: Wall Art (Decorative Artwork)
                        Group {
                            Text("P-12: Wall Art (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("wallArt")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p12_wall_art")
                        }

                        Divider()

                        // P-13: Bar Chart (Chart / Data Viz)
                        Group {
                            Text("P-13: Bar Chart (Chart / Data Viz Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("barChartReal")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p13_bar_chart_real")
                        }

                        Divider()

                        // P-14: Divider (Plain Shape)
                        Group {
                            Text("P-14: Divider (Plain Shape Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("divider")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p14_divider")
                        }

                        Divider()

                        // P-15: Typography Poster (Decorative Artwork)
                        Group {
                            Text("P-15: Typography Poster (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("typographyPoster")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p15_typography_poster")
                        }

                        Divider()

                        // P-16: Scanned Receipt (Scanned Document)
                        Group {
                            Text("P-16: Scanned Receipt (Scanned Document Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("scannedReceipt")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p16_scanned_receipt")
                        }

                        Divider()

                        // P-17: Product With Brand (Brand Logo)
                        Group {
                            Text("P-17: Product With Brand (Brand Logo Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("productWithBrand")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p17_product_with_brand")
                        }

                        Divider()

                        // P-18: Pie Chart (Chart / Data Viz)
                        Group {
                            Text("P-18: Pie Chart (Chart / Data Viz Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("pieChartReal")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p18_pie_chart_real")
                        }

                        Divider()

                        // P-19: App Icon Logo (Brand Logo)
                        Group {
                            Text("P-19: App Icon Logo (Brand Logo Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("appIconLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p19_app_icon_logo")
                        }

                        Divider()

                        // P-20: Love Sticker (Decorative Artwork)
                        Group {
                            Text("P-20: Love Sticker (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("loveSticker")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p20_love_sticker")
                        }

                        Divider()

                        // P-21: Map Screenshot (Chart / Data Viz)
                        Group {
                            Text("P-21: Map Screenshot (Chart / Data Viz Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("mapScreenshot")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p21_map_screenshot")
                        }

                        Divider()

                        // P-22: Loading Skeleton (Plain Shape)
                        Group {
                            Text("P-22: Loading Skeleton (Plain Shape Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("loadingSkeleton")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p22_loading_skeleton")
                        }

                        Divider()

                        // P-23: Greeting Card (Decorative Artwork)
                        Group {
                            Text("P-23: Greeting Card (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("greetingCard")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p23_greeting_card")
                        }

                        Divider()

                        // P-24: G-Shock Watch (Brand Text on Product)
                        Group {
                            Text("P-24: Watch Product Photo (Brand on Product Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("gshockWatch")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p24_gshock_watch")
                        }

                        Divider()

                        // P-25: Paddle Brush (Photograph, incidental brand text)
                        Group {
                            Text("P-25: Brush Product Photo (Brand on Product Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("paddleBrush")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p25_paddle_brush")
                        }

                        Divider()

                        // P-26: Mona Lisa Pop Art (Decorative Artwork, no text)
                        Group {
                            Text("P-26: Mona Lisa Pop Art (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("monaLisaArt")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p26_mona_lisa_art")
                        }

                        Divider()

                        // P-27: Stay Positive Frame (Decorative Typography Artwork)
                        Group {
                            Text("P-27: Framed Wall Art (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("stayPositiveFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p27_stay_positive_frame")
                        }

                        Divider()

                        // P-28: Yoga Se Hoga Showpiece (Decorative Artwork with artistic text)
                        Group {
                            Text("P-28: Showpiece (Decorative Artwork Exception)")
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Image("yogaSeHoga")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 160)
                                .accessibilityIdentifier("p28_yoga_se_hoga")
                        }
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                }
                .padding()
            }
            .padding()
            // Invisible helper that captures the backing UIScrollView
            .background(ScrollViewGrabber(holder: scrollViewHolder))
        }
        .overlay(alignment: .bottomTrailing) {
            scrollArrows
        }
        .navigationTitle("")
    }
}

#Preview {
    NavigationView {
        ImagesWithTextView()
    }
}
