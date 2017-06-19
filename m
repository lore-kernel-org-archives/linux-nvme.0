From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 16:58:45 +0300
Subject: [PATCH rfc 10/30] nvme: Add admin_tagset pointer to nvme_ctrl
In-Reply-To: <20170619124138.GJ29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-11-git-send-email-sagi@grimberg.me>
 <20170619124138.GJ29061@lst.de>
Message-ID: <2e697102-4560-f104-f1c9-cd7c3733b386@grimberg.me>


>> Will be used when we centralize control flows. only
>> rdma for now.
> 
> Should we at some point move the tag_sets themselves to the generic
> ctrl instead of just pointers?

We can easily do that, but the tagsets are heavily read in the hot path
so I was careful not to completely move them to nvme_ctrl which is not
arranged for it at all (and transports through it far back in their
struct).

Once we actually get some of this merged we should look into arranging
the transport controllers to be:

struct transport_ctrl {
	/* transport specific accessed in the hot path */
	...

	struct nvme_ctrl ctrl; /* hot members first */

	/* transport specific bookkeeping */
	...
};
