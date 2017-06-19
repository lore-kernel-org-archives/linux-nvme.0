From: hch@lst.de (Christoph Hellwig)
Date: Mon, 19 Jun 2017 09:13:14 +0200
Subject: [PATCH rfc 01/30] nvme: Add admin connect request queue
In-Reply-To: <1497799324-19598-2-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170619071314.GA13168@lst.de>

On Sun, Jun 18, 2017@06:21:35PM +0300, Sagi Grimberg wrote:
> In case we reconnect with inflight admin IO we
> need to make sure that the connect comes before
> the admin command. This can be only achieved by
> using a seperate request queue for admin connects.

Use up a few more lines of the available space for your lines? :)

Wouldn't a head insertation also solve the problem?
