From: hch@lst.de (Christoph Hellwig)
Date: Sun, 6 Nov 2016 20:24:51 +0100
Subject: [PATCH RFC nvme-cli 0/2] auto generate hostnqn file on
 installation
In-Reply-To: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
Message-ID: <20161106192451.GA18342@lst.de>

On Sun, Nov 06, 2016@09:12:59PM +0200, Sagi Grimberg wrote:
> Not sure if it's the best way to do this as my packeging understanding is
> very limited, hence the RFC. the debian part is tested (don't have
> access to rpm distros at the moment).

My idea was to add a command to generate an automatic hostnqn to
the nvme tool instead, what would you think about that?  The install
scripts could then call that.
