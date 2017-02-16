From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 16 Feb 2017 17:37:41 +0000
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <20170216173856.GB17828@localhost.localdomain>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org> <20170216025357.GA9241@redhat.com>
 <20170216142621.GA21972@infradead.org> <20170216151337.GA12678@redhat.com>
 <20170216173856.GB17828@localhost.localdomain>
Message-ID: <1487266648.2612.3.camel@sandisk.com>

On Thu, 2017-02-16@12:38 -0500, Keith Busch wrote:
> Maybe I'm not seeing the bigger picture. Is there some part to multipath
> that the kernel is not in a better position to handle?

Does this mean that the code to parse /etc/multipath.conf will be moved into
the kernel? Or will we lose the ability to configure the policies that
/etc/multipath.conf allows to configure?

Bart.
