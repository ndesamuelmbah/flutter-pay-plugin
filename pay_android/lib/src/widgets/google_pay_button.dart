part of '../../pay_android.dart';

enum GooglePayButtonType { pay, checkout, donate }
enum GooglePayButtonStyle { black, white, flat }

class RawGooglePayButton extends StatelessWidget {
  static const double minimumButtonWidth =
      _GooglePayButtonTypeAsset.defaultAssetWidth;
  static const double defaultButtonHeight = 36;

  final VoidCallback? onPressed;
  final GooglePayButtonStyle style;
  final GooglePayButtonType type;

  const RawGooglePayButton({
    Key? key,
    this.onPressed,
    this.style = GooglePayButtonStyle.black,
    this.type = GooglePayButtonType.pay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget rawButton = RawMaterialButton(
      fillColor:
          style == GooglePayButtonStyle.black ? Colors.black : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: style == GooglePayButtonStyle.flat
            ? const BorderSide(
                color: Color(0xFFDEDEDE),
                width: 2,
              )
            : BorderSide.none,
      ),
      child: SvgPicture.asset(
        'assets/${type.asset}_${style.assetSuffix}.svg',
        package: 'pay_android',
        semanticsLabel: 'Buy with Google Pay text',
        height: 17,
      ),
    );

    return Container(
      decoration: style == GooglePayButtonStyle.white
          ? BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ])
          : null,
      height: defaultButtonHeight,
      child: rawButton,
    );
  }
}

extension _GooglePayButtonTypeAsset on GooglePayButtonType {
  static const defaultAsset = 'gpay_logo';
  static const defaultAssetWidth = 54.0;

  String get asset =>
      {
        GooglePayButtonType.pay: 'buy_with_gpay',
        GooglePayButtonType.checkout: defaultAsset,
        GooglePayButtonType.donate: 'donate_with_gpay',
      }[this] ??
      defaultAsset;
}

extension _GooglePayButtonStyleAsset on GooglePayButtonStyle {
  static const defaultAssetSuffix = 'dark';

  String get assetSuffix =>
      {
        GooglePayButtonStyle.black: defaultAssetSuffix,
        GooglePayButtonStyle.white: 'clear',
        GooglePayButtonStyle.flat: 'clear',
      }[this] ??
      defaultAssetSuffix;
}