From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 30 Oct 2016 17:05:40 +0200
Subject: question about working with SRQ in nvmet_rdma from multiples hosts
In-Reply-To: <af00bab6-e995-fdad-a117-bcdd39ae2a1d@mellanox.com>
References: <af00bab6-e995-fdad-a117-bcdd39ae2a1d@mellanox.com>
Message-ID: <277acdca-d463-ca28-a5b7-15e374e2a003@grimberg.me>

> Hi,
>
> Maybe I'm missing something but it seems there is a bug in the SRQ
> implementation in nvmet_rdma,
>
> In case we work with two different hosts that are connected to the same
> SRQ we can get two different commands with the same command_id.

That can definitely happen, but whats the problem with that?
The command_id is just a handle that the host is sending us and
expects it when we send it a completion, we don't have any state around
it in the target stack...

> I couldn't found any related code that handle this issue.
>
> is it a problem? should we use qp_number to change the command_id to be
> unique across different hosts?

There is no such requirement. Again, the tags are allocated in the host
side. The only place the target *would* use the command_id is when
handling aborts, and like lots of other devices, we have a the absolute
minimum for aborts (no-op). Also, aborts are per-controller and we can
easily handle that, no need for host-wide uniqueness of tags...
