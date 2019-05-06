From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 01:35:43 +0900
Subject: [PATCH] nvme-trace: Add fabrics command opcode name
In-Reply-To: <20190506163114.GA9468@lst.de>
References: <20190505152201.23830-1-minwoo.im.dev@gmail.com>
 <SN6PR04MB45270E164CBC599246428CE386300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190506163114.GA9468@lst.de>
Message-ID: <c19254ec-3734-23db-d46d-d7b91c3f3253@gmail.com>

On 5/7/19 1:31 AM, Christoph Hellwig wrote:
> On Mon, May 06, 2019@04:29:12PM +0000, Chaitanya Kulkarni wrote:
>> Please do not mix admin and fabric commands.
> 
> Well, "the" fabrics command is an opcode that can show up on
> admin or I/O queues.  "the" because it actually is a multiplexer,
> and we probably want to decode it instead of just saying fabrics
> command in the traces.
> 

I'll prepare V2 patch with decoding opcode to show which fabrics 
commands are going on in the trace.

Thanks,
