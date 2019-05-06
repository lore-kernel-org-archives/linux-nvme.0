From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 May 2019 18:31:14 +0200
Subject: [PATCH] nvme-trace: Add fabrics command opcode name
In-Reply-To: <SN6PR04MB45270E164CBC599246428CE386300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505152201.23830-1-minwoo.im.dev@gmail.com>
 <SN6PR04MB45270E164CBC599246428CE386300@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190506163114.GA9468@lst.de>

On Mon, May 06, 2019@04:29:12PM +0000, Chaitanya Kulkarni wrote:
> Please do not mix admin and fabric commands.

Well, "the" fabrics command is an opcode that can show up on
admin or I/O queues.  "the" because it actually is a multiplexer,
and we probably want to decode it instead of just saying fabrics
command in the traces.
