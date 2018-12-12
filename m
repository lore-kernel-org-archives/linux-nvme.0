From: jalee@purestorage.com (Jaesoo Lee)
Date: Tue, 11 Dec 2018 17:31:23 -0800
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
In-Reply-To: <c645f196-3fbb-c9b9-5686-730ceed102fa@grimberg.me>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <b7b26a7a-70be-d805-ee64-67fba0b4efa8@mellanox.com>
 <CAJX3Cti_ZJF5E+NRuRzSeEUgaXsbA2U9C+Rh5OdYd4EMwXC1gw@mail.gmail.com>
 <773bb91f-40a4-a525-f7b8-db821b402821@mellanox.com>
 <CAJX3Ctjtt2zebuLfzKM30PV1x3fm8HaJJFJw3zZSOShWnQnu=Q@mail.gmail.com>
 <c645f196-3fbb-c9b9-5686-730ceed102fa@grimberg.me>
Message-ID: <CAJX3Ctg9rn2JyTL1xfb2htWjPaB3qj9t4gV=QZ+3yjGbCNz8UA@mail.gmail.com>

Please drop this patch. However, it would be happy if this bug can be
fixed as soon as possible.

Nitzan, do you mind if you send your patch for review?
On Tue, Dec 11, 2018@3:39 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> > I cannot reproduce the bug with the patch; in my failure scenarios, it
> > seems that completing the request on errors in nvme_rdma_send_done
> > makes __nvme_submit_sync_cmd to be unblocked. Also, I think this is
> > safe from the double completions.
> >
> > However, it seems that nvme_rdma_timeout code is still not free from
> > the double completion problem. So, it looks promising to me if you
> > could separate out the nvme_rdma_wr_error handling code as a new
> > patch.
>
> Guys, can you please send proper patches so we can review properly?
