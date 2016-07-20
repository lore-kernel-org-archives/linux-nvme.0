From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Jul 2016 11:42:04 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <12b64608-1d42-ffe6-c11a-58139cbabd3a@sandisk.com>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
 <12b64608-1d42-ffe6-c11a-58139cbabd3a@sandisk.com>
Message-ID: <578F395C.3000006@grimberg.me>


> The IB spec defines an end-to-end credit mechanism for RC connections.
> So if the transport layer is reliable (InfiniBand, RoCE with DCB
> enabled) setting the retry count high enough is only needed to avoid
> connection shutdown due to brief cable disconnect/reconnect events.

Right, this is why I think the driver can use whatever it sees fit (we
have a keep-alive mechanism for fast-fail functionality).
