From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Nov 2018 01:25:20 -0800
Subject: SGL Descriptor Type for NVMe over TCP
In-Reply-To: <MWHPR08MB268594BDB56161FEAD2CAA4FC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
References: <MWHPR08MB268594BDB56161FEAD2CAA4FC0D90@MWHPR08MB2685.namprd08.prod.outlook.com>
Message-ID: <20181121092520.GA18683@infradead.org>

On Tue, Nov 20, 2018@06:10:23PM +0000, Narayan Ayalasomayajula wrote:
> The SGL Descriptor Type for NVMe/TCP transport is defined as "Transport SGL Data Block descriptor" and looking at the source code, this appears to have a value of 0x5. Will this definition be included in the next version of the NVM Express specification?

It is defined in NVMe TP 4008, which you can download from
nvmexpress.org, and which will also be included in the next NVMe
specification.
