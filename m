From: james.smart@broadcom.com (James Smart)
Date: Wed, 2 Nov 2016 13:51:39 -0700
Subject: [PATCH v3 7/7] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <1477512029.3009.114.camel@linux.intel.com>
References: <580d0fff.s6PUdAo4MvJBY1Pu%james.smart@broadcom.com>
 <1477512029.3009.114.camel@linux.intel.com>
Message-ID: <6efa209e-45ce-7ca0-0be3-71fc5a2c8c72@broadcom.com>



On 10/26/2016 1:00 PM, J Freyensee wrote:
>
> Nitpick- looks odd to use a pointer variable instead of *newnport for
> the sizeof parameter, especially when that is the way '*opts' is done a
> few lines above it.

yep - resolved.


> ...
>> +			goto out_free_opts;
> It looks like if we ever get here, we will leak memory as newnport has
> been kzalloc'ed at this point but this will jump to the "out_free_opts"
> goto statement.

yes - fixed.

>
>> +static ssize_t
>> +fcloop_create_remote_port(struct device *dev, struct
>> device_attribute *attr,
>> +		const char *buf, size_t count)
>> +{
>> +	struct nvme_fc_remote_port *remoteport;
>> +	struct fcloop_nport *nport;
>> +	struct fcloop_rport *rport;
>> +	struct nvme_fc_port_info pinfo;
>> +	int ret;
>> +
>> +	nport = fcloop_alloc_nport(buf, count, true);
>> +	if (!nport)
>> +		return -EIO;
>> +
>> +	pinfo.node_name = nport->node_name;
>> +	pinfo.port_name = nport->port_name;
>> +	pinfo.port_role = nport->port_role;
>> +	pinfo.port_id = nport->port_id;
>> +
>> +	ret = nvme_fc_register_remoteport(nport->lport->localport,
>> +						&pinfo,
>> &remoteport);
>> +	if (ret || !remoteport) {
>> +		fcloop_nport_put(nport);
>> +		return ret;
> Possible memory leak for nport??

Nope. the alloc_nport() takes a reference (either allocation, or sharing 
it with a targetport).  Thus, the put releases it. If last reference, 
it's freed.


>
>> +
>> +static ssize_t
>> +fcloop_create_target_port(struct device *dev, struct
>> device_attribute *attr,
>> +		const char *buf, size_t count)
>> +{
>> +...
> Possible memory leak by not de-allocating 'nport'?

Nope: same answer as last. The ref counting will manage it.


Thanks

-- james
