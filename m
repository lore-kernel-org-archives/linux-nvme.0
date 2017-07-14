From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 14 Jul 2017 14:56:29 +0000
Subject: [dm-devel] [PATCH 1/4] libmultipath: get_udev_uid: make sure
 pp->wwid is 0-terminated
In-Reply-To: <20170714113209.17177-2-mwilck@suse.com>
References: <20170714113209.17177-1-mwilck@suse.com>
 <20170714113209.17177-2-mwilck@suse.com>
Message-ID: <1500044188.2662.4.camel@wdc.com>

On Fri, 2017-07-14@13:32 +0200, Martin Wilck wrote:
> If the first WWID_LEN bytes of the uuid_attribute do not contain
> a 0 byte, pp->wwid may end up not properly terminated. Fix it.
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> ---
>  libmultipath/discovery.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
> index 663c8eaa..9951af84 100644
> --- a/libmultipath/discovery.c
> +++ b/libmultipath/discovery.c
> @@ -1615,6 +1615,7 @@ get_udev_uid(struct path * pp, char *uid_attribute, struct udev_device *udev)
>  			len = strlen(value);
>  		}
>  		strncpy(pp->wwid, value, len);
> +		pp->wwid[WWID_SIZE - 1] = '\0';
>  	} else {
>  		condlog(3, "%s: no %s attribute", pp->dev,
>  			uid_attribute);

Hi Martin,

Your patch does not cause all overflows to be reported. How about using the
following (untested) alternative?

diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
index eca4ce97..80d962e6 100644
--- a/libmultipath/discovery.c
+++ b/libmultipath/discovery.c
@@ -1607,13 +1607,8 @@ get_udev_uid(struct path * pp, char *uid_attribute, struct udev_device *udev)
 	if (!value || strlen(value) == 0)
 		value = getenv(uid_attribute);
 	if (value && strlen(value)) {
-		if (strlen(value) + 1 > WWID_SIZE) {
+		if (strlcpy(pp->wwid, value, sizeof(pp->wwid)) >= WWID_SIZE)
 			condlog(0, "%s: wwid overflow", pp->dev);
-			len = WWID_SIZE;
-		} else {
-			len = strlen(value);
-		}
-		strncpy(pp->wwid, value, len);
 	} else {
 		condlog(3, "%s: no %s attribute", pp->dev,
 			uid_attribute);
Bart.
