From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 19 Jul 2017 03:06:20 +0000
Subject: [PATCH v2 1/4] libmultipath: get_udev_uid: make sure pp->wwid is
 0-terminated
In-Reply-To: <20170718072916.24275-2-mwilck@suse.com>
References: <20170718072916.24275-1-mwilck@suse.com>
 <20170718072916.24275-2-mwilck@suse.com>
Message-ID: <1500433579.32119.0.camel@wdc.com>

On Tue, 2017-07-18@09:29 +0200, Martin Wilck wrote:
> If the first WWID_LEN bytes of the uuid_attribute do not contain
> a 0 byte, pp->wwid may end up not properly terminated. Fix it by
> using strlcpy() rather than strncpy().

Reviewed-by: Bart Van Assche <bart.vanassche at wdc.com>
