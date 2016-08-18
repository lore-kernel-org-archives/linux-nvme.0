From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Aug 2016 10:44:49 +0300
Subject: [PATCH 2/2] nvme-rdma: Add handling for connecting to IPv6 targets
In-Reply-To: <CAG4TOxPNnUKWeh7FUY8YB127sx8yMu41FuP4hxUMCan_HWQmVQ@mail.gmail.com>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
 <1469950060-18098-2-git-send-email-roland@kernel.org>
 <4acdd466-b8f6-8208-7287-e97dfd45bbf1@grimberg.me>
 <33dfc646-1804-363e-4d83-1ba618303dbb@grimberg.me>
 <20160801110956.GI16141@lst.de>
 <e6e54d3f-c6ee-2057-d4e5-13981cd95140@grimberg.me>
 <20160801155036.GC22771@lst.de>
 <CAG4TOxPNnUKWeh7FUY8YB127sx8yMu41FuP4hxUMCan_HWQmVQ@mail.gmail.com>
Message-ID: <2b4f4727-58b5-c62e-e5fd-cc5e5b4ae6be@grimberg.me>


> I think adding a new helper that parses both v4 and v6 addresses +
> scope ID seems like the best thing for now.  I did a grep for in6_pton
> and it looks like at least fs/cifs/netmisc.c and net/sunrpc/addr.c
> could use the helper.
>
> What do you think of adding inet_pton_with_scope() to
> net/core/utils.c?  I'm open to better ideas on the name.  But I can
> code that up and use it in nvme, as well as convert over the two
> places I mentioned above.  The first parameter of the function can be
> an af, and the caller can pass in AF_UNSPEC, AF_INET, or AF_INET6 to
> restrict the parsing to one type of address (or not).

Hey Roland,

Are you looking into this?

I'd love to get it into 4.9...
