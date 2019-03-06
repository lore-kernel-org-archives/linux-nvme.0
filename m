From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 6 Mar 2019 20:31:21 +0000
Subject: [PATCH 2/2 blktests] nvme: test out-of-range I/O access
References: <20190306094643.10262-1-sagi@grimberg.me>
 <20190306094643.10262-2-sagi@grimberg.me>
 <SN6PR04MB452756E3DF3765A66DE3120086730@SN6PR04MB4527.namprd04.prod.outlook.com>
 <0d3d4384-7f75-cac4-ff8a-5ca4b8f879d2@grimberg.me>
Message-ID: <SN6PR04MB45276238286089534AEA3D0C86730@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/6/19 12:28 PM, Sagi Grimberg wrote:
> 
>>> +DESCRIPTION="unit test NVMe-oF out of range access"
>> it will be great if you can specify above back-end type (bdev/file)
> 
> OK
> 
>>> +QUICK=1
>>> +
>>> +requires() {
>>> +	_have_program nvme && _have_modules nvme-loop && _have_modules loop && \
>>> +		_have_configfs
>>
>> need to check for the blockdev.
> 
> Other tests use blockdev and don't check for it..

Yes, while looking at the code, I've also observed we don't check for 
the truncate as well. At least for the NVMe I'll send a patch-series to 
fix that for all the other tests.
> 
>>> +}
>>> +
>>> +test() {
>>> +	echo "Running ${TEST_NAME}"
>>> +
>>> +	modprobe nvmet
>>> +	modprobe nvme-loop
>>> +
>>> +	local port
>>> +	local nvmedev
>>> +	local file_path="$TMPDIR/img"
>>> +	local subsys_name="blktests-subsystem-1"
>>> +
>>> +	truncate -s 1G "${file_path}"
>>> +
>>> +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
>>> +		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>> +	port="$(_create_nvmet_port "loop")"
>>> +	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
>>> +
>>> +	nvme connect -t loop -n "${subsys_name}"
>>> +
>>> +	nvmedev="$(_find_nvme_loop_dev)"
>>> +	cat "/sys/block/${nvmedev}n1/uuid"
>>> +	cat "/sys/block/${nvmedev}n1/wwid"
>>> +
>>> +	sectors=$(blockdev --getsz /dev/${nvmedev}n1)
>>> +	bs=$(blockdev --getbsz /dev/${nvmedev}n1)
>>> +
>>> +	nvme read "/dev/${nvmedev}n1" -s $sectors -c 0 -z $bs
>>> +	if [[ ! $? ]]; then
>>> +		echo "Sucessfully read out of device lba range"
>> Can we prefix this message with error as we should get an error for
>> out of range ?
>>
>> Also s/Sucessfully/Successfully/.
> 
> Will do.
> 
