From: azher@hep.caltech.edu (Azher Mughal)
Date: Tue, 17 Jan 2017 08:18:48 -0800
Subject: Monitoring NVMe M.2 temperature
In-Reply-To: <5d4f81ef-16a6-d417-e66c-13e39e0a73e4@grimberg.me>
References: <a6d82f2f-9b2f-7309-31fa-30a85c03f01b@hep.caltech.edu>
 <5d4f81ef-16a6-d417-e66c-13e39e0a73e4@grimberg.me>
Message-ID: <4b883a24-8519-72ed-2af0-ce865710578b@hep.caltech.edu>

Thanks.

On 1/17/2017 12:27 AM, Sagi Grimberg wrote:
>
>> Hi All,
>>
>> I am testing Samsung M.2 drives (SM 961 and 950 PRO) in a Dell quad M.2
>> enclosure. Is there a way to monitor the temperature for an individual
>> drive ?
>
> nvme smart-log /dev/$nvme_ctrl
