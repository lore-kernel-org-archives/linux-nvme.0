From: hch@lst.de (Christoph Hellwig)
Date: Fri, 19 Jan 2018 20:12:06 +0100
Subject: [PATCH 2/2] nvme: Don't use a stack buffer for keep-alive command
In-Reply-To: <CAG4TOxOtFqM-RAdS_r1hsPVuru_=abDtTUmB=XqGFaanBrqbEQ@mail.gmail.com>
References: <20180111213815.2107-1-roland@kernel.org>
 <76436c6a-5dee-b174-3b39-2735f8dc3a05@grimberg.me>
 <20180115084240.GA32313@lst.de>
 <CAG4TOxOtFqM-RAdS_r1hsPVuru_=abDtTUmB=XqGFaanBrqbEQ@mail.gmail.com>
Message-ID: <20180119191206.GA19975@lst.de>

On Tue, Jan 16, 2018@02:46:43PM -0800, Roland Dreier wrote:
> > I think we'll need to fix this properly and embedd the struct nvme_command
> > into struct nvme_request.  In the end any command could get an error
> > without DNR, and then we'd have a stale SQE on the stack.
> 
> I don't understand.  Are there other places that submit requests with
> a pointer to stack memory?  I haven't audited everything but I don't
> know of any places that submit a command and then free it before
> getting status back.

Every caller of nvme_alloc_request (except for lightnvm) uses stack
memory, but at least the __nvme_submit_sync_cmd and
nvme_submit_user_cmd synchronously wait for the completion, so it
doesn't matter.  That leaves nvme_keep_alive, nvme_timeout and
nvme_delete_queue as problematic.

I suspect the right answer is to embedd a struct nvme_command into
struct nvme_request instead of just pointing to it.
