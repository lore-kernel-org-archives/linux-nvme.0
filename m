From: oren.duer@gmail.com (Oren Duer)
Date: Sun, 3 Jun 2018 17:01:59 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
 <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>
 <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
 <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>
Message-ID: <CADZhsQppPdtrJ+wRQV-V8n9RmxFgv39aPdu5TwDMtTTbD4iT1A@mail.gmail.com>

On Sun, Jun 3, 2018@2:30 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>> Sagi,
>>
>> our architecture team have presented MR features and improvments during
>> OFA 2018, and there are some similar ideas to your idea below. We need to
>> thing and plan how to progress here.
>
>
> I have not attended the OFA workshop.

We started pushing a new approach to all that cool MR registration stuff.
Presented in last OFA conf:
https://www.openfabrics.org/images/2018workshop/presentations/301_TOved_NonContiguousMemoryRegistration.pdf

The basic idea is aligned with your proposal: allocating an MR,
setting a memory layout to it using a variety
of ibv_mr_set_layout_*() calls, and then posting a WR.

This framework then can be expanded to support DIF, as was also
presented in the same conference:
https://www.openfabrics.org/images/2018workshop/presentations/301_TOved_NonContiguousMemoryRegistration.pdf
Basically, we're proposing DIF to be yet another memory layout using
ibv_mr_set_layout_signature().

This was all proposed for user space, but I believe we would like to
keep kernel and user verbs as similar as possible.

> Try to hide all the multiple mr madness...

Not so sure here. Some implementations will want to control the MRs
explicitly. On targets, for instance,
data buffers can be in full control of the target implementation, in
which case each buffer (or bunch of them)
will be pre-registered with mr that will be kept across different IOs.


-- 
Oren
