From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 22:54:32 -0700
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <493df3a7-6d25-9fd1-57ff-addbf37fcf22@suse.de>
Message-ID: <785558d1-519d-78c1-0a1b-7517f771c1e2@grimberg.me>


> I do like the idea, but not necessarily the naming.
> Can't we just call it 'default.conf' ?

It's not as self-explanatory, but I'm fine with default.conf...

> What about precedence?
> I would have expected that we should have
> 
> defargs.conf
> discovery.conf
> <cmdline>
> 
> Is that the case?

Effectively yes, but defargs does not allow transport,traddr,trsvcid,nqn
parameters (which don't make sense), and discovery.conf is designed to
hold exactly those. So in practice they should not overlap.

Also, we only go to discovery.conf if we did not get a transport+traddr
(which are mandatory). So its not exactly the order you mentioned, more
like:

defargs.conf
<cmdline>
if transport+traddr not given
discovery.conf

> And shouldn't we document that somewhere?
Where would be the place to update this?
