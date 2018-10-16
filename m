From: hare@suse.de (Hannes Reinecke)
Date: Tue, 16 Oct 2018 07:52:25 +0200
Subject: [PATCH 2/3] nvme: add test for ANA state transition
In-Reply-To: <20181015212600.GD23044@vader>
References: <20181015070130.6695-1-hare@suse.de>
 <20181015070130.6695-3-hare@suse.de> <20181015212600.GD23044@vader>
Message-ID: <3a470a85-bb1b-c0a7-e83c-5334c61297a6@suse.de>

On 10/15/18 11:26 PM, Omar Sandoval wrote:
> On Mon, Oct 15, 2018@09:01:29AM +0200, Hannes Reinecke wrote:
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>   tests/nvme/018     | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/nvme/018.out |  18 +++++++
>>   2 files changed, 159 insertions(+)
>>   create mode 100755 tests/nvme/018
>>   create mode 100644 tests/nvme/018.out
>>
>> diff --git a/tests/nvme/018 b/tests/nvme/018
>> new file mode 100755
>> index 0000000..4d9b6c7
>> --- /dev/null
>> +++ b/tests/nvme/018
>> @@ -0,0 +1,141 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Regression test for ANA base support
>> +#
>> +# Copyright (C) 2018 Hannes Reinecke, SUSE Linux GmbH
>> +#
>> +
>> +. tests/nvme/rc
>> +
>> +DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
>> +QUICK=1
>> +
>> +switch_nvmet_anagroup() {
>> +	local port1="$1"
>> +	local port2="$2"
>> +	local mode="$3"
>> +
>> +	echo "ANA state ${mode}"
>> +
>> +	if [ "${mode}" = "change" ] ; then
>> +		_set_nvmet_anagroup_state "${port1}" "1" "change"
>> +		_set_nvmet_anagroup_state "${port1}" "2" "change"
>> +		_set_nvmet_anagroup_state "${port2}" "1" "change"
>> +		_set_nvmet_anagroup_state "${port2}" "2" "change"
>> +	elif [ "${mode}" = "failover" ] ; then
>> +		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
>> +		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
>> +		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
>> +		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
>> +	else
>> +		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
>> +		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
>> +		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
>> +		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
>> +	fi
>> +}
>> +
>> +requires() {
>> +	_have_program nvme && _have_module nvme-loop && _have_module loop && \
>> +		_have_configfs && _have_fio
> 
> You didn't address the comments from last time (this needs _have_program
> mkfs.xfs and _have_module nvmet, IIRC). You also didn't respond to my
> rqeuest that this detects if ANA support is available in the kernel. I
> had to figure out that I needed CONFIG_NVME_MULTIPATH=y.
> 
And even that is not sufficient; the user might have disabled the use of 
native nvme multipathing on the kernel commandline.
I see what I can do to fix it up.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
