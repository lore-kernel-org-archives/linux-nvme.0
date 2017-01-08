From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 06:05:07 -0800
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20170108140507.GA32432@infradead.org>

On Thu, Dec 29, 2016@12:26:51PM -0700, Scott Bauer wrote:
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
> ---

Please use the proper @ sign for email addresses.

> +#define TPER_SYNC_SUPPORTED BIT(0)
> +
> +#define TINY_ATOM_DATA_MASK GENMASK(5, 0)

I know some people suggest to use BIT and GENMASK, but I find these
horrible to read compared to the traditional C notations..

> +static const u8 OPALUID[][8] = {

As per the last run: please no actual variable declarations in header
files, these arrays belong into a .c file, e.g. opal_proto.c or simply
in sed-opal.c

> +
> +/* Useful tiny atoms.
> + * Useful for table columns etc
> + */
> +enum OPAL_TINY_ATOM {
> +	OPAL_TINY_UINT_00 = 0x00,
> +	OPAL_TINY_UINT_01 = 0x01,
> +	OPAL_TINY_UINT_02 = 0x02,
> +	OPAL_TINY_UINT_03 = 0x03,
> +	OPAL_TINY_UINT_04 = 0x04,
> +	OPAL_TINY_UINT_05 = 0x05,
> +	OPAL_TINY_UINT_06 = 0x06,
> +	OPAL_TINY_UINT_07 = 0x07,
> +	OPAL_TINY_UINT_08 = 0x08,
> +	OPAL_TINY_UINT_09 = 0x09,
> +	OPAL_TINY_UINT_10 = 0x0a,
> +	OPAL_TINY_UINT_11 = 0x0b,
> +	OPAL_TINY_UINT_12 = 0x0c,
> +	OPAL_TINY_UINT_13 = 0x0d,
> +	OPAL_TINY_UINT_14 = 0x0e,
> +	OPAL_TINY_UINT_15 = 0x0f,
> +};

Just using 0/1/.../15 in decimal notation directly in the code would be a
lot easier to read I think :)

> +
> +struct opal_cmd {
> +	cont_fn *cb;
> +	void *cb_data;

It seems like these are both unused.



> +	opal_step error_cb;

This one always seems to be end_opal_session_error, which suggests
it could be replaced with a direct call.

> +	bool save_discovery;

And this just points back to the opal_dev, so it might as well
be removed.

> +		dev->prev_data = kmemdup(cpos, epos - cpos, GFP_KERNEL);

The kmemdup return value needs to be checked for errors.

> +	if (!supported) {
> +		pr_err("This device is not Opal enabled. Not Supported!\n");
> +		return 1;
> +	}
> +
> +	if (!single_user)
> +		pr_warn("Device doesn't support single user mode\n");
> +
> +
> +	if (!foundComID) {
> +		pr_warn("Could not find OPAL comid for device. Returning early\n");
> +		return 1;
> +	}
> +
> +	dev->comid = comid;
> +
> +	return 0;

Maybe switch the return value to a bool?  Also please change foundComID
to normal Linux variable spelling, e.g. found_comid.

> +	cmd->cmd = cmd->cmd_buf;
> +	cmd->resp = cmd->resp_buf;
> +
> +	dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
> +	cmd->cmd = (u8 *)round_up((uintptr_t)cmd->cmd, dma_align);
> +	cmd->resp = (u8 *)round_up((uintptr_t)cmd->resp, dma_align);

The block layer will automatically bounce buffer non-aligned payloads.
If the cost of copying is too high we could switch back to dynamic
allocations using kmalloc here, which will be properly aligned.

Also ->cmd and ->resp probably should be void pointers, so that no
casting is required for the various command and response structures.

> +static struct opal_dev *get_opal_dev(struct sed_context *sedc,
> +				     const opal_step *funcs)
> +{
> +	struct opal_dev *dev = sedc->dev;
> +	if (dev) {
> +		mutex_lock(&dev->dev_lock);
> +		dev->state = 0;
> +		dev->funcs = funcs;
> +		dev->tsn = 0;
> +		dev->hsn = 0;
> +		dev->error_cb = end_opal_session_error;
> +		dev->error_cb_data = dev;
> +		dev->func_data = NULL;
> +		dev->prev_data = NULL;
> +		dev->sed_ctx = sedc;
> +		dev->save_discovery = false;
> +	}
> +	return dev;
> +}

This seems to be a bit misnamed.  In the this starts a OPAL session,
so maybe the name should reflect that?

Also it seems a bit odd to hide the sedc->dev derference in here,
why not have the caller do that if it's needed, which for the few
callers I looked at shouldn't even be nessecary.

e.g.

	struct opal_dev *dev = sedc->dev;

	mutex_lock(&dev->dev_lock);
	opal_start_session(dev);
	...
	mutex_lock(&dev->dev_lock);

That beeing said I'm also a bit confused about all the structures.
It seems like sed_context and opal_dev could easily be merged.  With
two little accessors the memembers would not even have to be exposed
publicly.

Also opal_cmd only seems to exist in the form of being embedded into
opal_dev, so I don't strictly see the need for it either.

> +	if(!suspend)

missing whitespace before the (

> +	list_for_each_entry(suspend, &dev->unlk_lst, node) {
> +			dev->state = 0;
> +			dev->func_data[1] = &suspend->unlk.session;

doube indentation.

> +			dev->func_data[2] = &suspend->unlk;
> +			if (suspend->unlk.session.sum)
> +				dev->funcs = ulk_funcs_sum;
> +			else
> +				dev->funcs = _unlock_funcs;
> +			dev->tsn = 0;
> +			dev->hsn = 0;
> +			ret = next(dev);
> +			if (ret)
> +				was_failure = true;
> +	}
> +	mutex_unlock(&dev->dev_lock);
> +	return was_failure ? 1 : 0;

Just return was_failure and change the prototype to return a bool
as well.

> + *Drivers can use this to pass necessary data required for
> + *Their implementation of send/recv.
> + * @dev: Currently an Opal Dev structure. In the future can be other types
> + *Of security structures.
> + * @supported: Whether or not the device is sed supported.

There should always be a whitespace after the * in kernel comments.

In general it might be worth to run scripts/checkpath.pl over your
patches before sending them and fix all errors, while the warnings
are to be taken with a grain of salt unfortunately.

> +/*
> + * sec_ops - transport specific Trusted Send/Receive functions
> +* See SPC-4 for specific definitions
> + *
> + * @sec_send: sends the payload to the trusted peripheral
> + *     spsp: Security Protocol Specific
> + *     secp: Security Protocol
> + *     buf: Payload
> + *     len: Payload length
> + * @recv: Receives a payload from the trusted peripheral
> + *     spsp: Security Protocol Specific
> + *     secp: Security Protocol
> + *     buf: Payload
> + *     len: Payload length
> + */
> +struct sec_ops {
> +	int (*sec_send)(void *ctrl_data, u16 spsp, u8 secp, void *buf, size_t len);
> +	int (*sec_recv)(void *ctrl_data, u16 spsp, u8 secp, void *buf, size_t len);
> +};

These aren't actually used.

> +int sed_ioctl(struct sed_context *sed_ctx, unsigned int cmd, unsigned long arg);
> +
> +#endif /* LINUX_SED_H */
> -- 
> 2.7.4
> 
---end quoted text---
