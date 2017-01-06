From: james.p.freyensee@intel.com (Freyensee, James P)
Date: Fri, 6 Jan 2017 20:34:56 +0000
Subject: targetcli and nvmetcli
In-Reply-To: <cab11273-41c3-9af5-9263-e4d251b2c927@redhat.com>
References: <cab11273-41c3-9af5-9263-e4d251b2c927@redhat.com>
Message-ID: <1483734894.5538.14.camel@intel.com>

On Fri, 2017-01-06@11:05 -0800, Andy Grover wrote:
> Hi James and Christoph,
> 
> Have you considered integrating nvmetcli with targetcli?
> 
> I see there being reasons why it was developed as a standalone, but I'm?
> not sure how many of these still apply.
> 
> Especially given their shared source history, combining them at the cli?
> level, or even the lib level, would be straightforward, and could give?
> users a unified tool for managing both types of targets.
> 
> What do you think?

I donno, in my opinion, it seems from support/maintenance to philosophy
difference it would be confusing and difficult to combine the two. ?NVMe is a
new storage protocol with its own terminology (ex namespaces vs LUNS), defined
in its own standard, written by its own standard body that reserves the right
to not necessarily follow what iSCSI does (though there are a few borrowed
concepts like IQNs), and is supported by its own Linux email list.

Christoph has done design work on both the NVMe Target and LIO so he could give
a more intelligent technical answer than me.

Jay

> 
> Thanks -- Regards -- Andy
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
