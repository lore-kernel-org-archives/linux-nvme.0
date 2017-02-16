From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Feb 2017 20:05:36 +0200
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <20170216151337.GA12678@redhat.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org> <20170216025357.GA9241@redhat.com>
 <20170216142621.GA21972@infradead.org> <20170216151337.GA12678@redhat.com>
Message-ID: <8ce207d3-844a-8190-9644-1f54dbd7d56b@grimberg.me>


> I'm fine with the path selectors getting moved out; maybe it'll
> encourage new path selectors to be developed.
>
> But there will need to be some userspace interface stood up to support
> your native NVMe multipathing (you may not think it needed but think in
> time there will be a need to configure _something_).  That is the
> fragmentation I'm referring to.

I guess one config option that we'd need is multibus vs. failover
which are used per use-case.

I'd have to say that having something much simpler than multipath-tools
does sound appealing.
