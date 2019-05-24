From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 00:35:27 -0700
Subject: [PATCH v2 0/9] Add Subsystem/Ctrl/Namespace relations (nvme-cli)
In-Reply-To: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
References: <1558602058-29434-1-git-send-email-maxg@mellanox.com>
Message-ID: <285cd2f5-4d17-3bd5-751f-a2255cceaedb@grimberg.me>


> This patchset introduce few small bug fixes for memory leaks, improve
> coding style, improve code readability and mainly focus on the "nvme list-subsys"
> command. This command will show the whole NVM subsystem list (same as "nvme list"
> does for namespaces).
> The patchset ends with adding namespaces entry per each ctrl in the system.
> Actually, at first stage, we'll print only the namespace handle (nvme0n1 for
> example). Later on, we can add more attribute per demand (uuid, nguid, capacity,
> etc...).

Can you split patches 1-5 to a separate fixes series? Would be easier to
review.

As for the list-subsys, I think that when passing the namespace handle
it should only output the corresponding namespace from each controller.

list-subsys in my mind should probably stay as is without a namespace
handle passed because it doesn't give any meaningful information without
the mpath-namespace to slaves mapping.

Instead, a more effective display would be the mapping of each mpath
namespace to the corresponding slave namespaces. Perhaps with a new
command "list-mpath"?

On a side question, what does this information give the user if the
slave devices don't have a device node?
