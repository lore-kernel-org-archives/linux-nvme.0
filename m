From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 3 Jun 2018 19:30:41 +0300
Subject: [PATCH 17/17] nvme-rdma: Add T10-PI support
In-Reply-To: <CADZhsQppPdtrJ+wRQV-V8n9RmxFgv39aPdu5TwDMtTTbD4iT1A@mail.gmail.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-18-git-send-email-maxg@mellanox.com>
 <f45105cf-48e7-62d8-ca3a-56f9ce248640@grimberg.me>
 <20621565-ac87-9af2-364e-d6f84dbbadcf@mellanox.com>
 <af64b181-d673-0399-811a-4f60154b93ee@grimberg.me>
 <CADZhsQppPdtrJ+wRQV-V8n9RmxFgv39aPdu5TwDMtTTbD4iT1A@mail.gmail.com>
Message-ID: <fac46518-d14c-5856-8b99-f14203f53639@grimberg.me>

Hey Oren,

> We started pushing a new approach to all that cool MR registration stuff.
> Presented in last OFA conf:
> https://www.openfabrics.org/images/2018workshop/presentations/301_TOved_NonContiguousMemoryRegistration.pdf
> 
> The basic idea is aligned with your proposal: allocating an MR,
> setting a memory layout to it using a variety
> of ibv_mr_set_layout_*() calls, and then posting a WR.

Hmm, in my mind, overloading the interface to be generic was counter
productive specifically for PI. I know that there are bunch of
operations to do on an MR, but I think that each of them is better off
with its own clean and simple API that gives the user the minimum stuff
it needs to understand or perform in order to get the task done.

> This framework then can be expanded to support DIF, as was also
> presented in the same conference:
> https://www.openfabrics.org/images/2018workshop/presentations/301_TOved_NonContiguousMemoryRegistration.pdf
> Basically, we're proposing DIF to be yet another memory layout using
> ibv_mr_set_layout_signature().
> 
> This was all proposed for user space, but I believe we would like to
> keep kernel and user verbs as similar as possible.

I understand that this approach unifies all the MR operations with the
concept of a layout. But I think that the ULP would want an interface
that maps in a simple and clean conversion from upper level PI into
verbs PI.

>> Try to hide all the multiple mr madness...
> 
> Not so sure here. Some implementations will want to control the MRs
> explicitly. On targets, for instance,
> data buffers can be in full control of the target implementation, in
> which case each buffer (or bunch of them)
> will be pre-registered with mr that will be kept across different IOs.

I think this is ignoring how all our kernel consumers use MRs today and
in the foreseeable future. What I see is that our ULPs are exposed to
more than they probably want just for a theoretical level of freedom
for a use-case that I don't think will ever find its way to the kernel.

Moreover, I'm also not absolutely sure that the current API is not
dictating how RDMA vendors should implement PI.

Note that my comments are mostly directed to the MR hierarchy that PI
is presenting to the consumer. I think we are much better off with
hiding it down in the providers such that the ULP will see yet another
type of a memory region that can do PI.
