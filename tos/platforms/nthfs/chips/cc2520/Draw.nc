
/**
 *We need it because "tos/chips/cc2520/CC2520DriverLayerP.nc:98: interface Draw not found"
 */


/**
 * Heavily inspired by the at91 library.
 * @author Thomas Schmid
 **/

interface Draw
{
    async command void fill(uint32_t color);

    async command void drawPixel(
            uint32_t x,
            uint32_t y,
            uint32_t c);

    async command void drawRectangle(
            uint32_t x,
            uint32_t y,
            uint32_t width,
            uint32_t height,
            uint32_t color);

    async command void drawString(
            uint32_t x,
            uint32_t y,
            const char *pString,
            uint32_t color);

    async command void drawStringWithBGColor(
            uint32_t x,
            uint32_t y,
            const char *pString,
            uint32_t fontColor,
            uint32_t bgColor);

    async command void drawInt(
            uint32_t x,
            uint32_t y,
            uint32_t n,
            int8_t sign,
            uint32_t fontColor);

    async command void drawIntWithBGColor(
            uint32_t x,
            uint32_t y,
            uint32_t n,
            int8_t sign,
            uint32_t fontColor,
            uint32_t bgColor);

    async command void getStringSize(
            const char *pString,
            uint32_t *pWidth,
            uint32_t *pHeight);

    async command void drawChar(
            uint32_t x,
            uint32_t y,
            char c,
            uint32_t color);

    async command void drawCharWithBGColor(
            uint32_t x,
            uint32_t y,
            char c,
            uint32_t fontColor,
            uint32_t bgColor);
}
