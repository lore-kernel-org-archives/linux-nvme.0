From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 14 Jul 2017 15:40:02 +0200
Subject: [PATCH nvmetcli] nvmetcli: Also configure subsystem version
In-Reply-To: <20170714133836.19369-1-jthumshirn@suse.de>
References: <20170714133836.19369-1-jthumshirn@suse.de>
Message-ID: <20170714134002.GB13633@linux-x5ow.site>

On Fri, Jul 14, 2017@03:38:36PM +0200, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  nvmetcli | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/nvmetcli b/nvmetcli
> index 354ce4826f11..a8d648a2179c 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -149,6 +149,7 @@ class UISubsystemNode(UINode):
>      ui_desc_attr = {
>          'allow_any_host': ('string', 'Allow access by any host if set to 1'),
>          'serial': ('string', 'Export serial number to hosts'),
> +	'version': ('string', 'Export version number to hosts'),

Gah tab instead of space...

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
