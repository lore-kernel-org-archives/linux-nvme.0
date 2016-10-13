From: roysh@mellanox.com (Roy Shterman)
Date: Thu, 13 Oct 2016 17:13:07 +0300
Subject: Scalability issue with multiple NVMe Devices with one core
In-Reply-To: <20161013141820.GA17823@localhost.localdomain>
References: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>
 <20161013141820.GA17823@localhost.localdomain>
Message-ID: <6d4d9ff4-c0f5-3bbb-ec11-f156039b8518@mellanox.com>



On 10/13/2016 5:18 PM, Keith Busch wrote:
> On Thu, Oct 13, 2016@08:44:37AM +0300, Roy Shterman wrote:
>> scenario is when running traffic over 1 NVMe Device with 1 core I'm getting
>> X IOPS and Y% core utilization.
>>
>> In my perception, when adding more NVMe Devices I should see some linearity
>> of the above results, but I'm getting only a small improvement in IOPS and
>> still not getting 100% (or closer ) in CPU utilization.
>>
>> Any suggestions?
> How are you generating IO?
Sorry, last response I sent was with IODEPTH=1, I'm changing the IODEPTH 
to 8-32.
