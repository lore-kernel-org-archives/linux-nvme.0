From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Sat, 4 Nov 2017 12:22:20 +0100
Subject: [PATCH 3/3] nvme: fix eui_show() print format
In-Reply-To: <1509722197.15520.17.camel@perches.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-4-git-send-email-javier@cnexlabs.com>
 <20171103125516.GC25186@lst.de> <1509722197.15520.17.camel@perches.com>
Message-ID: <2AC384A2-C792-45AF-AF11-89CBC128C527@lightnvm.io>

> On 3 Nov 2017,@16.16, Joe Perches <joe@perches.com> wrote:
> 
> On Fri, 2017-11-03@13:55 +0100, Christoph Hellwig wrote:
>> On Fri, Nov 03, 2017@11:02:50AM +0100, Javier Gonz?lez wrote:
>>> Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
> []
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> []
>>> @@ -2108,7 +2108,7 @@ static ssize_t eui_show(struct device *dev, struct device_attribute *attr,
>>> 								char *buf)
>>> {
>>> 	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
>>> -	return sprintf(buf, "%8phd\n", ns->eui);
>>> +	return sprintf(buf, "%8phD\n", ns->eui);
>>> }
>>> static DEVICE_ATTR(eui, S_IRUGO, eui_show, NULL);
>> 
>> This looks correct.  I wonder what the old code printed - does someone
>> have a device with an EUI-64 at hand to quickly cross check what we
>> did before?
> 
> It uses spaces between bytes and not dashes.
> 
> The code has been this way a couple years now.
> 
> I think this proposal, while it might fix an
> unintentional output style, could also be an API
> and could cause user breakage if changed.
> 
> Perhaps this should just become
> 
> 	%8ph
> 
> without D

That would be ok with me.

Javier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171104/47095145/attachment.sig>
