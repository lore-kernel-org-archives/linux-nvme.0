From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 5 Jun 2018 23:54:30 +0300
Subject: Bug report: critical medium error during 8k local nvme write
In-Reply-To: <20180605162053.GC16899@localhost.localdomain>
References: <93935ee4-52eb-a514-1b46-21c0f3b6e31d@mellanox.com>
 <20180605162053.GC16899@localhost.localdomain>
Message-ID: <7e7f1a1c-6e70-7bbf-c1b0-ad1123897897@mellanox.com>



On 6/5/2018 7:20 PM, Keith Busch wrote:
> On Tue, May 29, 2018@04:08:08PM +0300, Max Gurtovoy wrote:
>> hi Keith,
>> I want to report on a bug I've seen in my local nvme drive configured to run
>> with metadata format using:
> 
> I think you got this one fixed in your patch "nvme: Fix extended data
> LBA supported setting".
> 

Yup :)
Currenly working on fixing other issue with verifing integrity for IO > 
mdts...
