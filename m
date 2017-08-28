From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Aug 2017 11:40:35 -0700
Subject: [GIT PULL] nvme update for Linux 4.14
In-Reply-To: <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
 <20170828155925.GA32254@infradead.org>
 <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
 <20170828175744.GA26713@infradead.org>
 <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
Message-ID: <20170828184035.GA11383@infradead.org>

Meh, I don't think that'll work out - the rdma refactoring from
Sagi deeply depends on the un?nit_ctrl split..
