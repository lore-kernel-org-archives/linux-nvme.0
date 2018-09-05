From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 05 Sep 2018 08:24:52 -0700
Subject: [PATCH 1/5] block: genhd: add 'groups' argument to device_add_disk
In-Reply-To: <20180905070053.26239-2-hare@suse.de>
References: <20180905070053.26239-1-hare@suse.de>
 <20180905070053.26239-2-hare@suse.de>
Message-ID: <1536161092.11534.1.camel@acm.org>

On Wed, 2018-09-05@09:00 +0200, Hannes Reinecke wrote:
> Update device_add_disk() to take an 'groups' argument so that
> individual drivers can register a device with additional sysfs
> attributes.
> This avoids race condition the driver would otherwise have if these
> groups were to be created with sysfs_add_groups().

Reviewed-by: Bart Van Assche <bvanassche at acm.org>
