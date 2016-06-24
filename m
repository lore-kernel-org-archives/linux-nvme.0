From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Fri, 24 Jun 2016 16:41:19 +0200 (CEST)
Subject: [nvme-fabrics]Fabrics over ROCEv2
In-Reply-To: <E47B62BF-F8ED-40B9-8700-33CDFDB5AD1A@mellanox.com>
References: <1755342088.51635051.1466689109109.JavaMail.zimbra@kalray.eu>
 <20160624071312.GD4252@infradead.org>
 <394543770.53385548.1466766141681.JavaMail.zimbra@kalray.eu>
 <8AB89CFA-063B-4C85-9B68-3BAE2E9F0B1D@mellanox.com>
 <1187980791.54028200.1466778741463.JavaMail.zimbra@kalray.eu>
 <E47B62BF-F8ED-40B9-8700-33CDFDB5AD1A@mellanox.com>
Message-ID: <490655406.54097546.1466779279070.JavaMail.zimbra@kalray.eu>



----- Le 24 Juin 16, ? 16:38, Majd Dibbiny majd at mellanox.com a ?crit :

>> On Jun 24, 2016,@5:32 PM, Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>> 
>> 
>> 
>> ----- Le 24 Juin 16, ? 15:40, Majd Dibbiny majd at mellanox.com a ?crit :
>> 
>>>> On Jun 24, 2016,@2:02 PM, Marta Rybczynska <mrybczyn@kalray.eu> wrote:
>>>> 
>>>> Hello Christoph,
>>>> Thanks for the answer. I do indeed have more general problems with
>>>> ROCEv2: ib_send_bw works fine for ROCEv1 but not with ROCEv2. I'm
>>>> going to follow with the Mellanox persons as it seems to be mlx4 or
>>>> configuration-related.
>>> Hi Marta,
>>> 
>>> Do you run with RDMA-CM?
>>> Can you please provide the command lines you use and the GIDs table?
>> 
>> Hello Majd,
>> Yes, it's using RDMA-CM. I have re-connected the network and the
> This might be related to the fact that you need to configure the RDMA CM mode
> using configfs. (By default it's V1)


This isn't in fact working for me in 4.7+ (does work fine in OFED kernel 3.10).
Write to default_roce_mode does give Permission denied even for root (haven't 
debugged this one, however).

-- 

Marta Rybczynska 

Phone : +33 6 71 09 68 03 
mrybczyn at kalray.eu
