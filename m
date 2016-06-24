From: majd@mellanox.com (Majd Dibbiny)
Date: Fri, 24 Jun 2016 14:38:00 +0000
Subject: [nvme-fabrics]Fabrics over ROCEv2
In-Reply-To: <1187980791.54028200.1466778741463.JavaMail.zimbra@kalray.eu>
References: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>
 <20160624071312.GD4252@infradead.org>
 <394543770.53385548.1466766141681.JavaMail.zimbra@kalray.eu>
 <8AB89CFA-063B-4C85-9B68-3BAE2E9F0B1D@mellanox.com>,
 <1187980791.54028200.1466778741463.JavaMail.zimbra@kalray.eu>
Message-ID: <E47B62BF-F8ED-40B9-8700-33CDFDB5AD1A@mellanox.com>


> On Jun 24, 2016,@5:32 PM, Marta Rybczynska <mrybczyn@kalray.eu> wrote:
> 
> 
> 
> ----- Le 24 Juin 16, ? 15:40, Majd Dibbiny majd at mellanox.com a ?crit :
> 
>>> On Jun 24, 2016,@2:02 PM, Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>>> 
>>> Hello Christoph,
>>> Thanks for the answer. I do indeed have more general problems with
>>> ROCEv2: ib_send_bw works fine for ROCEv1 but not with ROCEv2. I'm
>>> going to follow with the Mellanox persons as it seems to be mlx4 or
>>> configuration-related.
>> Hi Marta,
>> 
>> Do you run with RDMA-CM?
>> Can you please provide the command lines you use and the GIDs table?
> 
> Hello Majd,
> Yes, it's using RDMA-CM. I have re-connected the network and the
This might be related to the fact that you need to configure the RDMA CM mode using configfs. (By default it's V1) 
> machines have 
> rebooted (unrelated panic) and now it's working fine. If I'm able to reproduce 
> the problem, I will keep you updated.
> 
> Thanks for the help all,
> Marta
