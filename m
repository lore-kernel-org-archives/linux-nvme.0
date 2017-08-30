From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 30 Aug 2017 12:55:42 +0300
Subject: [PATCH v2] nvme-fabrics: Prevent KATO to be set as 0
In-Reply-To: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>
References: <20170829220346.19424-1-gpiccoli@linux.vnet.ibm.com>
Message-ID: <d67a9ef4-8c01-f842-3eed-4ef873c22dfd@grimberg.me>


> Since the debug feature of setting KATO to 0 is not working
> anymore, remove it from code. If user sets it to 0, default
> value will be explicitly used.

Why not allowing it? its pretty useful for testing.
