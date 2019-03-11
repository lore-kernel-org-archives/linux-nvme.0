From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:14:27 -0700
Subject: [PATCH 2/2 blktests] nvme: test out-of-range I/O access
In-Reply-To: <20190311203523.GA1315@vader>
References: <20190306094643.10262-1-sagi@grimberg.me>
 <20190306094643.10262-2-sagi@grimberg.me> <20190311203523.GA1315@vader>
Message-ID: <cdf619bc-1fbc-9244-907d-61fcba752730@grimberg.me>


>> Test that we correctly fail an out-of-range access
>> with a proper NVMe status code.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>>   tests/nvme/018     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/018.out |  6 +++++
>>   2 files changed, 64 insertions(+)
>>   create mode 100755 tests/nvme/018
>>   create mode 100755 tests/nvme/018.out
>>
>> diff --git a/tests/nvme/018 b/tests/nvme/018
>> new file mode 100755
>> index 000000000000..939573263c87
>> --- /dev/null
>> +++ b/tests/nvme/018
>> @@ -0,0 +1,58 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2018 Sagi Grimberg
>> +#
>> +# Test NVMe out of range access.
> 
> Is this a test for a specific kernel commit? It fails on 5.0.

It failed when nvmet file backend was introduced but fixed in one
of the -rc cycles. Thought it'd be worth keeping the test though...

I'll send v2
