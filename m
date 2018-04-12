From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 15:34:46 +0300
Subject: [PATCH 4/3 v1 nvmetcli] nvmetcli: expose nvmet port status and
 state
In-Reply-To: <4a97d73a-20f1-2a22-9fb5-589faebb8f65@mellanox.com>
References: <20180412080656.1691-1-sagi@grimberg.me>
 <20180412080656.1691-5-sagi@grimberg.me>
 <4a97d73a-20f1-2a22-9fb5-589faebb8f65@mellanox.com>
Message-ID: <f89cd973-0eb0-6ab1-7ab9-5e0a1882682d@grimberg.me>


> get_trstate is supposed to be available only for port nodes,
> so I think it is better to put it under class Port (which
> inherits from class CFSNode), rather than from class CFSNode itself.

You are absolutely correct, thanks!
