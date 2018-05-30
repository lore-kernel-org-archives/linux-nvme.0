From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:05:08 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <1527436222-15494-18-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
Message-ID: <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>

Max,

> For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
> protection information passthrough and validation for NVMe over RDMA transport.
> Similar to iSER, T10-PI offload support was implemented over RDMA signature
> verbs API and is enabled via module parameter. In the future we might want
> to add support per controller.

In NVMe we like to call inherited features differently, in nvme its
metadata and not T10-PI :)

Thanks for doing this btw!

Looking at the code, I realize that the rdma core API can improve
significantly. I think we can actually achieve a much better
abstraction of the HW implementation details. This would be a good
chance to clean it all up.

What I'm thinking of is we should have a single MR that
describes everything (data, metadata, signature parameters) instead
of exposing the use of multiple MRs via the API.

Here's how I think we can do it (and correct me where I'm wrong)
1. modify ib_alloc_mr to accept another parameter of max_meta_sg
which will tell the driver to allocate more "internal" mrs or entries
for a signature enabled MR (driver that does not support would fail if
its set or non-signature MR was requested).

2. introduce ib_map_mr_sg_sig that will accept both data and meta sgls
and will prepare the internal MR mappings.

3. have ib_sig_handover_wr perform whatever needed to do the job.
Which is posting the reg_mr for the "internal" mr(s).

Note that IIRC the Mellanox device can register with disabling the
device checking the MR was invalidated so it wouldn't need to be
locally invalidated (note that this is an internal MR that is private
to the driver with local access rights so no harm in not invalidating it).

4. Move ib_sig_attrs into a signature enabled ib_mr (dynamically
allocated).

5. Given that we now have two block consumers of this, add a better
abstraction helpers that take struct request and blk_integrity and
fill out the ib_sig_attrs accordingly...

Side note, the signature enabled MR can have only a single "internal"
mr because the strided format in the mlx5 signature segment is perfectly
capable of accepting two strides in a single lkey.

So consider a signature stride that takes two sgls:
data: {d1, d2, d3, d4}
meta: {m1, m2, m3, m4}

So the internal MR will look like:

            data start  meta start
            |           |
            -------------------------
            |d1|d2|d3|d4|m1|m2|m3|m4|
            -------------------------

and the sig_mr stride block would be same lkey but different
offsets in it (offset 0 and offset d1+d2+d3+d4)

Thoughts?
