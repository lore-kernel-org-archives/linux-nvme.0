From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 4 Dec 2018 09:18:22 -0800
Subject: [PATCH 10/13] nvme-mpath: remove I/O polling support
In-Reply-To: <20181204150729.GD3630@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
 <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>
 <20181204150729.GD3630@lst.de>
Message-ID: <76b2d640-aba6-3869-4420-8c09b8e2ea77@grimberg.me>


>>> If it really becomes an issue we
>>> should rework the nvme code to also skip the multipath code for any
>>> private namespace, even if that could mean some trouble when rescanning.
>>>
>>
>> This requires some explanation? skip the multipath code how?
> 
> We currently always go through the multipath node as long the the
> controller is multipath capable.  If we care about e.g. polling
> on a private namespace on a dual ported U.2 drive we'd have to make
> sure we don't go through the multipath device node for private namespaces
> that can only have one path, but only for shared namespaces.

But we'd still use the multipath node for shared namespaces (and also
polling if needed). I agree that private namespaces can skip the
multipath node.
