From: oren.duer@gmail.com (Oren Duer)
Date: Tue, 5 Jun 2018 09:35:29 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <fac46518-d14c-5856-8b99-f14203f53639@grimberg.me>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
 <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>
 <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
 <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>
 <CADZhsQppPdtrJ+wRQV-V8n9RmxFgv39aPdu5TwDMtTTbD4iT1A@mail.gmail.com>
 <fac46518-d14c-5856-8b99-f14203f53639@grimberg.me>
Message-ID: <CADZhsQpZe3PFBYdD07HvzHfF4TZf5ALH_iamfkEmH9bMQ0d9qQ@mail.gmail.com>

On Sun, Jun 3, 2018@7:30 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Hey Oren,
>
>> We started pushing a new approach to all that cool MR registration stuff.
>> Presented in last OFA conf:
>>
>> https://www.openfabrics.org/images/2018workshop/presentations/301_TOved_NonContiguousMemoryRegistration.pdf
>>
>> The basic idea is aligned with your proposal: allocating an MR,
>> setting a memory layout to it using a variety
>> of ibv_mr_set_layout_*() calls, and then posting a WR.
>
>
> Hmm, in my mind, overloading the interface to be generic was counter
> productive specifically for PI. I know that there are bunch of
> operations to do on an MR, but I think that each of them is better off
> with its own clean and simple API that gives the user the minimum stuff
> it needs to understand or perform in order to get the task done.

You can say the opposite too... When you see different use cases converge
into one elegant API then you know you've done something right.
I think this is one of those cases. DIF and other signatures, simple layouts,
indirections, complex n-dim matrix layouts are all attributes assigned to
memory, and apply when this memory is accessed.

> Note that my comments are mostly directed to the MR hierarchy that PI
> is presenting to the consumer. I think we are much better off with
> hiding it down in the providers such that the ULP will see yet another
> type of a memory region that can do PI.

We'll look into that. Basically I don't mind the API of
set_mr_layout_signature()
to take (data_sgl, dif_sgl) instead of (data_sge, dif_sge). Just need to make
sure we can hide in provider the pre-allocation of all the "hidden" mkeys for
that case. We don't want ulp to experience hickups due to internal key
allocations and management...

-- 
Oren
