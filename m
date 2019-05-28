From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 12:54:16 -0700
Subject: [PATCH 9/9] nvme: Retrieve namespaces during list-subsys cmd
In-Reply-To: <1558951310-31066-10-git-send-email-maxg@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
 <1558951310-31066-10-git-send-email-maxg@mellanox.com>
Message-ID: <f5eaed02-b448-913d-a3aa-580c5fd8dca0@grimberg.me>


> Add an association between subsystems/ctrls/namespaces using
> "nvme list-subsys" command. Now this command will show the following
> (notice that nvme-subsys4 is a dual controller subsystem that runs a
> native multipath configuration. Hidden block devices not presented):

I'm having a problem with the removal of the ANA state and the namespace
handle removal.

If you insist of having this display, please introduce it in a separate
command, don't just change how list-subsys acts (which is actually kinda
useful).

> nvme-subsys3 - NQN=nqn.2014.08.org.nvmexpress:80868086CVCQ5234001C400AGN INTEL SSDPEDMW400G4
> \
>   +- nvme0 pcie 0000:08:00.0 live
>   \
>    +- nvme3n1
> nvme-subsys4 - NQN=testsubsystem_0
> \
>   +- nvme4 rdma traddr=1.212.99.85 trsvcid=4420 live
>   \
>    +- nvme4n1
>    +- nvme4n2
>    +- nvme4n3
>   +- nvme5 rdma traddr=1.212.99.85 trsvcid=4420 live
>   \
>    +- nvme4n1
>    +- nvme4n2
>    +- nvme4n3

This is definitely better than the hidden devices though...
