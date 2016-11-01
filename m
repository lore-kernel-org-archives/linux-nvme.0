From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 1 Nov 2016 12:56:11 -0600
Subject: [RFC PATCH 2/6] lib: Add Sed-opal library
In-Reply-To: <1477951099-3127-3-git-send-email-scott.bauer@intel.com>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
 <1477951099-3127-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161101185611.GA1999@localhost.localdomain>

Hi Rafael, Scott,


First off, congrats on the set! It looks good so far.

Just some small nits below since you have to respin it anyways :)

On Mon, Oct 31, 2016@03:58:15PM -0600, Scott Bauer wrote:
> This patch implements the necessary logic to bring an Opal
> enabled drive out of a factory-enabled into a working
> Opal state.
> 
> This patch set also enables logic to save a password to
> be replayed during a resume from suspend. The key can be
> saved in the driver or in the Kernel's Key managment.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
> ---
>  lib/sed-opal.c          | 3337 +++++++++++++++++++++++++++++++++++++++++++++++
>  lib/sed-opal_internal.h |  586 +++++++++
>  lib/sed-opal_key.c      |   46 +
>  lib/sed.c               |  303 +++++
>  4 files changed, 4272 insertions(+)
>  create mode 100644 lib/sed-opal.c
>  create mode 100644 lib/sed-opal_internal.h
>  create mode 100644 lib/sed-opal_key.c
>  create mode 100644 lib/sed.c
> 
> diff --git a/lib/sed-opal.c b/lib/sed-opal.c
> new file mode 100644
> index 0000000..10b3348
> --- /dev/null
> +++ b/lib/sed-opal.c
> @@ -0,0 +1,3337 @@
> +/*
> + * Copyright ? 2016 Intel Corporation
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Authors:
> + *    Rafael Antognolli <rafael.antognolli at intel.com>
> + *    Scott  Bauer      <scott.bauer at intel.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ":OPAL: " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/genhd.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/sed-opal.h>
> +#include <linux/sed.h>
> +#include <linux/sed-opal.h>
> +#include <linux/string.h>
> +
> +#include "sed-opal_internal.h"
> +
> +#define IO_BUFFER_LENGTH 2048
> +
> +#define MAX_TOKS 64
> +
> +struct opal_cmd {
> +	struct block_device *bdev;
> +	sec_cb *cb;
> +	void *cb_data;
> +
> +	size_t pos;
> +	u8 cmd_buf[IO_BUFFER_LENGTH * 2];
> +	u8 resp_buf[IO_BUFFER_LENGTH * 2];
> +	u8 *cmd;
> +	u8 *resp;
> +};
> +
> +/*
> + * On the parsed response, we don't store again the toks that are already
> + * stored in the response buffer. Instead, for each token, we just store a
> + * pointer to the position in the buffer where the token starts, and the size
> + * of the token in bytes.
> + */
> +struct opal_resp_tok {
> +	const u8 *pos;
> +	size_t len;
> +	enum OPAL_RESPONSE_TOKEN type;
> +	enum OPAL_ATOM_WIDTH width;
> +	union {
> +		u64 u;
> +		s64 s;
> +	} stored;
> +};
> +
> +/*
> + * From the response header it's not possible to know how many tokens there are
> + * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
> + * if we start dealing with messages that have more than that, we can increase
> + * this number. This is done to avoid having to make two passes through the
> + * response, the first one counting how many tokens we have and the second one
> + * actually storing the positions.
> + */
> +struct parsed_resp {
> +	int num;
> +	struct opal_resp_tok toks[MAX_TOKS];
> +};
> +
> +struct opal_dev;
> +
> +typedef void (*opal_cb)(int error, struct opal_dev *dev);
> +
> +typedef int (*opal_step)(struct opal_dev *dev);
> +
> +struct opal_completion {
> +	struct completion cmd_completion;
> +	int completion_status;
> +};
> +
> +struct opal_dev {
> +	struct block_device *bdev;
> +	struct opal_completion *completion;
> +	struct opal_lock_unlock lkul;
> +	const opal_step *funcs;
> +	void **func_data;
> +	bool resume_from_suspend;
> +	struct opal_suspend_unlk *resume_data;
> +	size_t num_func_data;
> +	atomic_t in_use;
> +	sector_t start;
> +	sector_t length;
> +	u8 lr;
> +	u8 key_type;
> +	u8 key_name[OPAL_KEY_MAX];
> +	size_t key_name_len;
> +	u8 key[OPAL_KEY_MAX];
> +	size_t key_len;
> +	u16 comID;
> +	u32 HSN;
> +	u32 TSN;
> +	u64 align;
> +	u64 lowest_lba;
> +	struct list_head node;
> +	char disk_name[DISK_NAME_LEN];
> +	int state;
> +
> +	struct opal_cmd cmd;
> +	struct parsed_resp parsed;
> +
> +	size_t prev_d_len;
> +	void *prev_data;
> +
> +	sec_cb *final_cb;
> +	void *final_cb_data;
> +	opal_step error_cb;
> +	void *error_cb_data;
> +	opal_cb oper_cb;
> +};
> +
> +LIST_HEAD(opal_list);
> +DEFINE_SPINLOCK(list_spinlock);
> +
> +static void print_buffer(const u8 *ptr, u32 length)
> +{
> +#ifdef DEBUG
> +	print_hex_dump_bytes("OPAL: ", DUMP_PREFIX_OFFSET, ptr, length);
> +	pr_debug("\n");
> +#endif
> +}
> +
> +#define TPER_SYNC_SUPPORTED BIT(0)
> +
> +static bool check_tper(const void *data)
> +{
> +	const struct d0_tper_features *tper = data;
> +	u8 flags = tper->supported_features;
> +
> +	if (!(flags & TPER_SYNC_SUPPORTED)) {
> +		pr_err("TPer sync not supported. flags = %d\n",
> +		       tper->supported_features);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool check_SUM(const void *data)
> +{
> +	const struct d0_single_user_mode *sum = data;
> +	u32 nlo = be32_to_cpu(sum->num_locking_objects);
> +
> +	if (nlo == 0) {
> +		pr_err("Need at least one locking object.\n");
> +		return false;
> +	}
> +
> +	pr_debug("Number of locking objects: %d\n", nlo);
> +
> +	return true;
> +}
> +
> +static u16 get_comID_v100(const void *data)
> +{
> +	const struct d0_opal_v100 *v100 = data;
> +
> +	return be16_to_cpu(v100->baseComID);
> +}
> +
> +static u16 get_comID_v200(const void *data)
> +{
> +	const struct d0_opal_v200 *v200 = data;
> +
> +	return be16_to_cpu(v200->baseComID);
> +}
> +
> +static int __opal_send_cmd(struct opal_suspend_unlk *data, u16 comID,
> +			   void *buffer, size_t buflen, sec_cb *cb,
> +			   void *cb_data)
> +{
> +	return data->ops.send(data->data, comID, TCG_SECP_01, buffer, buflen,
> +			     cb, cb_data);
> +}
> +static int _opal_send_cmd(struct block_device *bdev, u16 comID,
> +			  void *buffer, size_t buflen,
> +			  sec_cb *cb, void *cb_data)
> +{
> +	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
> +
> +	return ops->send(bdev->bd_disk->private_data, comID,
> +			 TCG_SECP_01, buffer, buflen,
> +			 cb, cb_data);
> +}
> +
> +static int __opal_recv_cmd(struct opal_suspend_unlk *data, u16 comID,
> +			   void *buffer, size_t buflen, sec_cb *cb,
> +			   void *cb_data)
> +{
> +	return data->ops.recv(data->data, comID, TCG_SECP_01, buffer, buflen,
> +			     cb, cb_data);
> +}
> +
> +static int _opal_recv_cmd(struct block_device *bdev, u16 comID,
> +			  void *buffer, size_t buflen,
> +			  sec_cb *cb, void *cb_data)
> +{
> +	const struct sec_ops *ops = bdev->bd_disk->fops->sec_ops;
> +
> +	return ops->recv(bdev->bd_disk->private_data, comID,
> +			 TCG_SECP_01, buffer, buflen,
> +			 cb, cb_data);
> +}
> +
> +static void opal_send_cb_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +	size_t buflen = IO_BUFFER_LENGTH;
> +	void *buffer = dev->cmd.resp;
> +	struct opal_header *hdr = buffer;
> +
> +	pr_debug("%s: Sent OPAL command: error=%d, outstanding=%d, minTransfer=%d\n",
> +	       dev->disk_name, error, hdr->cp.outstandingData,
> +	       hdr->cp.minTransfer);
> +
> +	if (error || hdr->cp.outstandingData == 0 ||
> +	    hdr->cp.minTransfer != 0) {
> +		if (dev->cmd.cb)
> +			dev->cmd.cb(error, dev->cmd.cb_data);
> +		return;
> +	}
> +
> +	memset(buffer, 0, buflen);
> +	if (dev->resume_from_suspend)
> +		__opal_recv_cmd(dev->resume_data, dev->comID,
> +				buffer, buflen, opal_send_cb_cont, dev);
> +	else
> +		_opal_recv_cmd(dev->bdev, dev->comID, buffer, buflen,
> +			       opal_send_cb_cont, dev);
> +}
> +
> +static void opal_send_cb(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +	size_t buflen = IO_BUFFER_LENGTH;
> +	void *buffer = dev->cmd.resp;
> +
> +	if (error) {
> +		if (dev->cmd.cb)
> +			dev->cmd.cb(error, dev->cmd.cb_data);
> +		return;
> +	}
> +
> +	memset(buffer, 0, buflen);
> +	if (dev->resume_from_suspend)
> +		__opal_recv_cmd(dev->resume_data, dev->comID,
> +				buffer, buflen, opal_send_cb_cont, dev);
> +	else
> +		_opal_recv_cmd(dev->bdev, dev->comID, buffer, buflen,
> +			       opal_send_cb_cont, dev);
> +}
> +
> +static int opal_send_recv(struct opal_dev *dev, sec_cb *cb, void *cb_data)
> +{
> +	size_t buflen = IO_BUFFER_LENGTH;
> +	void *buffer = dev->cmd.cmd;
> +	int ret;
> +
> +	dev->cmd.cb = cb;
> +	dev->cmd.cb_data = cb_data;
> +	if (dev->resume_from_suspend)
> +		ret = __opal_send_cmd(dev->resume_data, dev->comID, buffer,
> +				      buflen, opal_send_cb, dev);
> +	else
> +		ret = _opal_send_cmd(dev->bdev, dev->comID, buffer, buflen,
> +				     opal_send_cb, dev);
> +
> +	return ret;
> +}
> +
> +static void check_geometry(struct opal_dev *dev, const void *data)
> +{
> +	const struct d0_geometry_features *geo = data;
> +
> +	dev->align = geo->alignment_granularity;
> +	dev->lowest_lba = geo->lowest_aligned_lba;
> +}
> +
> +static void opal_discovery0_end(int error, void *data)
> +{
> +	bool foundComID = false, supported = true, single_user = false;
> +	struct opal_dev *dev = data;
> +	const struct d0_header *hdr;
> +	const u8 *epos, *cpos;
> +	u16 comID = 0;
> +
> +	if (error) {
> +		pr_err("%s: Sending discovery0 failed\n", dev->disk_name);
> +		goto err_callback;
> +	}
> +
> +	epos = dev->cmd.resp;
> +	cpos = dev->cmd.resp;
> +	hdr = (struct d0_header *)dev->cmd.resp;
> +
> +	print_buffer(dev->cmd.resp, be32_to_cpu(hdr->length));
> +
> +	epos += be32_to_cpu(hdr->length); /* end of buffer */
> +	cpos += sizeof(*hdr); /* current position on buffer */
> +
> +	while (cpos < epos && supported) {
> +		const struct d0_features *body =
> +			(const struct d0_features *)cpos;
> +
> +		switch (be16_to_cpu(body->code)) {
> +		case FC_TPER:
> +			supported = check_tper(body->features);
> +			break;
> +		case FC_SINGLEUSER:
> +			single_user = check_SUM(body->features);
> +			break;
> +		case FC_GEOMETRY:
> +			check_geometry(dev, body);
> +			break;
> +		case FC_LOCKING:
> +		case FC_ENTERPRISE:
> +		case FC_DATASTORE:
> +			/* some ignored properties */
> +			pr_debug("%s: Found OPAL feature description: %d\n",
> +				 dev->disk_name, be16_to_cpu(body->code));
> +			break;
> +		case FC_OPALV100:
> +			comID = get_comID_v100(body->features);
> +			foundComID = true;
> +			break;
> +		case FC_OPALV200:
> +			comID = get_comID_v200(body->features);
> +			foundComID = true;
> +			break;
> +		default:
> +			if (be16_to_cpu(body->code) > 0xbfff) {
> +				/* vendor specific, just ignore */
> +			} else {
> +				pr_warn("%s: OPAL Unknown feature: %d\n",
> +					dev->disk_name, be16_to_cpu(body->code));
> +			}
Small nit, how about:

case 0xbfff ... 0xffff:
	/* vendor specific, just ignore */
	break;
default:
	pr_warn(...



> +		}
> +		cpos += body->length + 4;
> +	}
> +
> +	if (!supported) {
> +		pr_err("%s: Device not supported\n", dev->disk_name);
> +		goto err_callback;
> +	}
> +
> +	if (!single_user)
> +		pr_warn("%s: Device doesn't support single user mode\n",
> +			dev->disk_name);
> +
> +	if (!foundComID) {
> +		pr_warn("%s: Could not find OPAL comID for device. OPAL kernel unlocking will be disabled\n",
> +			dev->disk_name);
> +		goto err_callback;
> +	}
> +
> +	dev->comID = comID;
> +
> +err_callback:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +static int opal_discovery0(struct opal_dev *dev)
> +{
> +	memset(dev->cmd.resp, 0, IO_BUFFER_LENGTH);
> +
> +	if (dev->resume_from_suspend)
> +		return __opal_recv_cmd(dev->resume_data, 0x0001,
> +				       dev->cmd.resp, IO_BUFFER_LENGTH,
> +				       opal_discovery0_end, dev);
> +
> +	return _opal_recv_cmd(dev->bdev, 0x0001, dev->cmd.resp,
> +			      IO_BUFFER_LENGTH, opal_discovery0_end,
> +			      dev);
> +}
> +
> +static void add_token_u8(struct opal_cmd *cmd, u8 tok)
> +{
> +	cmd->cmd[cmd->pos++] = tok;
> +}
> +
> +static ssize_t test_and_add_token_u8(struct opal_cmd *cmd, u8 tok)
> +{
> +	BUILD_BUG_ON(IO_BUFFER_LENGTH >= SIZE_MAX);
> +
> +	if (cmd->pos >= IO_BUFFER_LENGTH - 1) {
> +		pr_err("Error adding u8: end of buffer.\n");
> +		return -ERANGE;
> +	}
> +
> +	add_token_u8(cmd, tok);
> +
> +	return 1;
> +}
> +
> +#define TINY_ATOM_DATA_MASK GENMASK(5, 0)
> +#define TINY_ATOM_SIGNED BIT(6)
> +
> +#define SHORT_ATOM_ID BIT(7)
> +#define SHORT_ATOM_BYTESTRING BIT(5)
> +#define SHORT_ATOM_SIGNED BIT(4)
> +#define SHORT_ATOM_LEN_MASK GENMASK(3, 0)
> +
> +static void add_short_atom_header(struct opal_cmd *cmd, bool bytestring,
> +				  bool has_sign, int len)
> +{
> +	u8 atom;
> +
> +	atom = SHORT_ATOM_ID;
> +	atom |= bytestring ? SHORT_ATOM_BYTESTRING : 0;
> +	atom |= has_sign ? SHORT_ATOM_SIGNED : 0;
> +	atom |= len & SHORT_ATOM_LEN_MASK;
> +
> +	add_token_u8(cmd, atom);
> +}
> +
> +#define MEDIUM_ATOM_ID (BIT(7) | BIT(6))
> +#define MEDIUM_ATOM_BYTESTRING BIT(4)
> +#define MEDIUM_ATOM_SIGNED BIT(3)
> +#define MEDIUM_ATOM_LEN_MASK GENMASK(2, 0)
> +
> +static void add_medium_atom_header(struct opal_cmd *cmd, bool bytestring,
> +				   bool has_sign, int len)
> +{
> +	u8 header0;
> +
> +	header0 = MEDIUM_ATOM_ID;
> +	header0 |= bytestring ? MEDIUM_ATOM_BYTESTRING : 0;
> +	header0 |= has_sign ? MEDIUM_ATOM_SIGNED : 0;
> +	header0 |= (len >> 8) & MEDIUM_ATOM_LEN_MASK;
> +	cmd->cmd[cmd->pos++] = header0;
> +	cmd->cmd[cmd->pos++] = len;
> +}
> +
> +static void add_token_u64(struct opal_cmd *cmd, u64 number, size_t len)
> +{
> +	add_short_atom_header(cmd, false, false, len);
> +
> +	while (len--) {
> +		u8 n = number >> (len * 8);
> +
> +		add_token_u8(cmd, n);
> +	}
> +}
> +
> +static ssize_t test_and_add_token_u64(struct opal_cmd *cmd, u64 number)
> +{
> +	int len;
> +	int msb;
> +
> +	if (!(number & ~TINY_ATOM_DATA_MASK))
> +		return test_and_add_token_u8(cmd, number);
> +
> +	msb = fls(number);
> +	len = DIV_ROUND_UP(msb, 4);
> +
> +	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
> +		pr_err("Error adding u64: end of buffer.\n");
> +		return -ERANGE;
> +	}
> +
> +	add_token_u64(cmd, number, len);
> +
> +	/* return length of token plus atom */
> +	return len + 1;
> +}
> +
> +static void add_token_bytestring(struct opal_cmd *cmd,
> +				 const u8 *bytestring, size_t len)
> +{
> +	memcpy(&cmd->cmd[cmd->pos], bytestring, len);
> +	cmd->pos += len;
> +}
> +
> +static ssize_t test_and_add_token_bytestring(struct opal_cmd *cmd,
> +					     const u8 *bytestring, size_t len)
> +{
> +	size_t header_len = 1;
> +	bool is_short_atom = true;
> +
> +	if (len & ~SHORT_ATOM_LEN_MASK) {
> +		header_len = 2;
> +		is_short_atom = false;
> +	}
> +
> +	if (cmd->pos >= IO_BUFFER_LENGTH - len - header_len) {
> +		pr_err("Error adding bytestring: end of buffer.\n");
> +		return -ERANGE;
> +	}
> +
> +	if (is_short_atom)
> +		add_short_atom_header(cmd, true, false, len);
> +	else
> +		add_medium_atom_header(cmd, true, false, len);
> +
> +	add_token_bytestring(cmd, bytestring, len);
> +
> +	return header_len + len;
> +}
> +
> +#define LOCKING_RANGE_NON_GLOBAL 0x03
> +
> +static int build_locking_range(u8 *buffer, size_t length, u8 lr)
> +{
> +	if (length < OPAL_UID_LENGTH)
> +		return -ERANGE;
> +
> +	memcpy(buffer, OPALUID[OPAL_LOCKINGRANGE_GLOBAL], OPAL_UID_LENGTH);
> +
> +	if (lr == 0)
> +		return 0;
> +	buffer[5] = LOCKING_RANGE_NON_GLOBAL;
> +	buffer[7] = lr;
> +
> +	return 0;
> +}
> +
> +static int build_locking_user(u8 *buffer, size_t length, u8 lr)
> +{
> +	if (length < OPAL_UID_LENGTH)
> +		return -ERANGE;
> +
> +	memcpy(buffer, OPALUID[OPAL_USER1_UID], OPAL_UID_LENGTH);
> +
> +	buffer[7] = lr + 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * N = number of format specifiers (1-999) to be replicated
> + * c = u8
> + * u = u64
> + * s = bytestring, length
> + *
> + * ret = test_and_add_token_va(cmd, "c",
> + *			       u8_val1);
> + *
> + * ret = test_and_add_token_va(cmd, "2c2u",
> + *			       u8_val1, u8_val2, u64_val1, u64_val2);
> + *
> + * ret = test_and_add_token_va(cmd, "3s",
> + *			       bytestring1, length1,
> + *			       bytestring2, length2,
> + *			       bytestring3, length3);
> + */
> +static int test_and_add_token_va(struct opal_cmd *cmd,
> +				 const char *fmt, ...)
> +{
> +	const u8 *it = fmt, *tmp;
> +	int ret, num = 1, sum = 0;
> +	va_list ap;
> +
> +	va_start(ap, fmt);
> +
> +	while (*it != '\0') {
> +		u64 tok64 = 0;
> +		u8 tok, *bstr;
> +		size_t len;
> +
> +		ret = 0;
> +
> +		switch (*it) {
> +		case '1' ... '9':
> +			tmp = it;
> +			num = 0;
> +			while (*tmp >= '0' && *tmp <= '9')
> +				num = num * 10 + (*tmp++ - '0');
> +			it = tmp;
> +			continue;
> +		case 'c':
> +			while (num--) {
> +				tok = va_arg(ap, unsigned int);
> +				ret = test_and_add_token_u8(cmd, tok);
> +				if (ret < 0)
> +					goto err;
> +			}
> +			num = 1;
> +			break;
> +		case 'u':
> +			while (num--) {
> +				tok64 = va_arg(ap, u64);
> +				ret = test_and_add_token_u64(cmd, tok64);
> +				if (ret < 0)
> +					goto err;
> +			}
> +			num = 1;
> +			break;
> +		case 's':
> +			while (num--) {
> +				bstr = va_arg(ap, u8 *);
> +				len = va_arg(ap, size_t);
> +				ret = test_and_add_token_bytestring(cmd, bstr,
> +								    len);
> +				if (ret < 0)
> +					goto err;
> +			}
> +			num = 1;
> +			break;
> +		case ' ':
> +		case '\t':
> +			/* ignored */
> +			break;
> +		default:
> +			pr_warn("Unrecognized type.\n");
> +		}
> +
> +		it++;
> +		sum += ret;
> +	}
> +
> +	va_end(ap);
> +
> +	return sum;
> +
> + err:
> +	pr_err("Token failed to be added.\n");
> +	return ret;
> +}
> +
> +static void set_comID(struct opal_cmd *cmd, u16 comID)
> +{
> +	struct opal_header *hdr = (struct opal_header *)cmd->cmd;
> +
> +	hdr->cp.extendedComID[0] = comID >> 8;
> +	hdr->cp.extendedComID[1] = comID;
> +	hdr->cp.extendedComID[2] = 0;
> +	hdr->cp.extendedComID[3] = 0;
> +}
> +
> +static int cmd_finalize(struct opal_cmd *cmd, u32 hsn, u32 tsn)
> +{
> +	struct opal_header *hdr;
> +	int ret;
> +
> +	ret = test_and_add_token_va(cmd, "6c",
> +				    OPAL_ENDOFDATA, OPAL_STARTLIST,
> +				    0, 0, 0, OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("Error finalizing command.\n");
> +		return -EFAULT;
> +	}
> +
> +	hdr = (struct opal_header *) cmd->cmd;
> +
> +	hdr->pkt.TSN = cpu_to_be32(tsn);
> +	hdr->pkt.HSN = cpu_to_be32(hsn);
> +
> +	hdr->subpkt.length = cpu_to_be32(cmd->pos - sizeof(*hdr));
> +	while (cmd->pos % 4) {
> +		if (cmd->pos >= IO_BUFFER_LENGTH) {
> +			pr_err("Error: Buffer overrun\n");
> +			return -ERANGE;
> +		}
> +		cmd->cmd[cmd->pos++] = 0;
> +	}
> +	hdr->pkt.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp) -
> +				      sizeof(hdr->pkt));
> +	hdr->cp.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp));
> +
> +	return 0;
> +}
> +
> +static enum OPAL_RESPONSE_TOKEN token_type(const struct parsed_resp *resp,
> +					   int n)
> +{
> +	const struct opal_resp_tok *tok;
> +
> +	if (n >= resp->num) {
> +		pr_err("Token number doesn't exist: %d, resp: %d\n",
> +		       n, resp->num);
> +		return OPAL_DTA_TOKENID_INVALID;
> +	}
> +
> +	tok = &resp->toks[n];
> +	if (tok->len == 0) {
> +		pr_err("Token length must be non-zero\n");
> +		return OPAL_DTA_TOKENID_INVALID;
> +	}
> +
> +	return tok->type;
> +}
> +
> +/*
> + * This function returns 0 in case of invalid token. One should call
> + * token_type() first to find out if the token is valid or not.
> + */
> +static enum OPAL_TOKEN response_get_token(const struct parsed_resp *resp,
> +					  int n)
> +{
> +	const struct opal_resp_tok *tok;
> +
> +	if (n >= resp->num) {
> +		pr_err("Token number doesn't exist: %d, resp: %d\n",
> +		       n, resp->num);
> +		return 0;
> +	}
> +
> +	tok = &resp->toks[n];
> +	if (tok->len == 0) {
> +		pr_err("Token length must be non-zero\n");
> +		return 0;
> +	}
> +
> +	return tok->pos[0];
> +}
> +
> +static size_t response_parse_tiny(struct opal_resp_tok *tok,
> +				  const u8 *pos)
> +{
> +	tok->pos = pos;
> +	tok->len = 1;
> +	tok->width = OPAL_WIDTH_TINY;
> +
> +	if (pos[0] & TINY_ATOM_SIGNED) {
> +		tok->type = OPAL_DTA_TOKENID_SINT;
> +	} else {
> +		tok->type = OPAL_DTA_TOKENID_UINT;
> +		tok->stored.u = pos[0] & 0x3f;
> +	}
> +
> +	return tok->len;
> +}
> +
> +static size_t response_parse_short(struct opal_resp_tok *tok,
> +				   const u8 *pos)
> +{
> +	tok->pos = pos;
> +	tok->len = (pos[0] & SHORT_ATOM_LEN_MASK) + 1;
> +	tok->width = OPAL_WIDTH_SHORT;
> +
> +	if (pos[0] & SHORT_ATOM_BYTESTRING) {
> +		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
> +	} else if (pos[0] & SHORT_ATOM_SIGNED) {
> +		tok->type = OPAL_DTA_TOKENID_SINT;
> +	} else {
> +		u64 u_integer = 0;
> +		int i, b = 0;
> +
> +		tok->type = OPAL_DTA_TOKENID_UINT;
> +		if (tok->len > 9)
Should this be len > 8 or len >= 9 ?

> +			pr_warn("uint64 with more than 8 bytes\n");
> +		for (i = tok->len - 1; i > 0; i--) {
> +			u_integer |= ((u64)pos[i] << (8 * b));
> +			b++;
> +		}
It doesn't look particularly safe to keep using this driver on a drive
if it returns a len > 8. But the specs do allow 16-byte data in a short
atom, so maybe we should bail on allowing the driver to manage the
drive, or change the types to some 16-byte type?

> +		tok->stored.u = u_integer;
> +	}
> +
> +	return tok->len;
> +}
> +
> +static size_t response_parse_medium(struct opal_resp_tok *tok,
> +				    const u8 *pos)
> +{
> +	tok->pos = pos;
> +	tok->len = (((pos[0] & MEDIUM_ATOM_LEN_MASK) << 8) | pos[1]) + 2;
> +	tok->width = OPAL_WIDTH_MEDIUM;
> +
> +	if (pos[0] & MEDIUM_ATOM_BYTESTRING)
> +		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
> +	else if (pos[0] & MEDIUM_ATOM_SIGNED)
> +		tok->type = OPAL_DTA_TOKENID_SINT;
> +	else
> +		tok->type = OPAL_DTA_TOKENID_UINT;
> +
> +	return tok->len;
> +}
> +
> +#define LONG_ATOM_ID (BIT(7) | BIT(6) | BIT(5))
> +#define LONG_ATOM_BYTESTRING BIT(1)
> +#define LONG_ATOM_SIGNED BIT(0)
> +static size_t response_parse_long(struct opal_resp_tok *tok,
> +				  const u8 *pos)
> +{
> +	tok->pos = pos;
> +	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
> +	tok->width = OPAL_WIDTH_LONG;
> +
> +	if (pos[0] & LONG_ATOM_BYTESTRING)
> +		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
> +	else if (pos[0] & LONG_ATOM_SIGNED)
> +		tok->type = OPAL_DTA_TOKENID_SINT;
> +	else
> +		tok->type = OPAL_DTA_TOKENID_UINT;
> +
> +	return tok->len;
> +}
> +
> +static size_t response_parse_token(struct opal_resp_tok *tok,
> +				   const u8 *pos)
> +{
> +	tok->pos = pos;
> +	tok->len = 1;
> +	tok->type = OPAL_DTA_TOKENID_TOKEN;
> +	tok->width = OPAL_WIDTH_TOKEN;
> +
> +	return tok->len;
> +}
> +
> +static int response_parse(const u8 *buf, size_t length,
> +			  struct parsed_resp *resp)
> +{
> +	const struct opal_header *hdr;
> +	struct opal_resp_tok *iter;
> +	int ret, num_entries = 0;
> +	u32 cpos = 0, total;
> +	size_t token_length;
> +	const u8 *pos;
> +
> +	if (!buf)
> +		return -EFAULT;
> +
> +	if (!resp)
> +		return -EFAULT;
> +
> +	hdr = (struct opal_header *)buf;
> +	pos = buf;
> +	pos += sizeof(*hdr);
> +
> +	pr_debug("Response size: cp: %d, pkt: %d, subpkt: %d\n",
> +		 be32_to_cpu(hdr->cp.length),
> +		 be32_to_cpu(hdr->pkt.length),
> +		 be32_to_cpu(hdr->subpkt.length));
> +
> +	if ((hdr->cp.length == 0)
> +	    || (hdr->pkt.length == 0)
> +	    || (hdr->subpkt.length == 0)) {
> +		pr_err("Bad header length. cp: %d, pkt: %d, subpkt: %d\n",
> +		       be32_to_cpu(hdr->cp.length),
> +		       be32_to_cpu(hdr->pkt.length),
> +		       be32_to_cpu(hdr->subpkt.length));
> +		print_buffer(pos, sizeof(*hdr));
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	if (pos > buf + length) {
> +		ret = -EFAULT;
> +		goto err;
> +	}
> +
> +	iter = resp->toks;
> +	total = be32_to_cpu(hdr->subpkt.length);
> +	print_buffer(pos, total);
> +	while (cpos < total) {
> +		if (!(pos[0] & 0x80)) /* tiny atom */
> +			token_length = response_parse_tiny(iter, pos);
> +		else if (!(pos[0] & 0x40)) /* short atom */
> +			token_length = response_parse_short(iter, pos);
> +		else if (!(pos[0] & 0x20)) /* medium atom */
> +			token_length = response_parse_medium(iter, pos);
> +		else if (!(pos[0] & 0x10)) /* long atom */
> +			token_length = response_parse_long(iter, pos);
> +		else /* TOKEN */
> +			token_length = response_parse_token(iter, pos);
> +
> +		pos += token_length;
> +		cpos += token_length;
> +		iter++;
> +		num_entries++;
> +	}
> +
> +	if (num_entries == 0) {
> +		pr_err("Couldn't parse response.\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	resp->num = num_entries;
> +
> +	return 0;
> +err:
> +	return ret;
> +}
> +
> +static size_t response_get_string(const struct parsed_resp *resp, int n,
> +				  const char **store)
> +{
> +	*store = NULL;
> +	if (!resp) {
> +		pr_err("Response is NULL\n");
> +		return 0;
> +	}
> +
> +	if (n > resp->num) {
> +		pr_err("Response has %d tokens. Can't access %d\n",
> +		       resp->num, n);
> +		return 0;
> +	}
> +
> +	if (resp->toks[n].type != OPAL_DTA_TOKENID_BYTESTRING) {
> +		pr_err("Token is not a byte string!\n");
> +		return 0;
> +	}
> +
> +	*store = resp->toks[n].pos + 1;
> +	return resp->toks[n].len - 1;
> +}
> +
> +static u64 response_get_u64(const struct parsed_resp *resp, int n)
> +{
> +	if (!resp) {
> +		pr_err("Response is NULL\n");
> +		return 0;
> +	}
> +
> +	if (n > resp->num) {
> +		pr_err("Response has %d tokens. Can't access %d\n",
> +		       resp->num, n);
> +		return 0;
> +	}
> +
> +	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
> +		pr_err("Token is not unsigned it: %d\n",
> +		       resp->toks[n].type);
> +		return 0;
> +	}
> +
> +	if (!((resp->toks[n].width == OPAL_WIDTH_TINY) ||
> +	      (resp->toks[n].width == OPAL_WIDTH_SHORT))) {
> +		pr_err("Atom is not short or tiny: %d\n",
> +		       resp->toks[n].width);
> +		return 0;
> +	}
> +
> +	return resp->toks[n].stored.u;
> +}
> +
> +static u8 response_status(const struct parsed_resp *resp)
> +{
> +	if ((token_type(resp, 0) == OPAL_DTA_TOKENID_TOKEN)
> +	    && (response_get_token(resp, 0) == OPAL_ENDOFSESSION)) {
> +		return 0;
> +	}
> +
> +	if (resp->num < 5)
> +		return DTAERROR_NO_METHOD_STATUS;
> +
> +	if ((token_type(resp, resp->num - 1) != OPAL_DTA_TOKENID_TOKEN) ||
> +	    (token_type(resp, resp->num - 5) != OPAL_DTA_TOKENID_TOKEN) ||
> +	    (response_get_token(resp, resp->num - 1) != OPAL_ENDLIST) ||
> +	    (response_get_token(resp, resp->num - 5) != OPAL_STARTLIST))
> +		return DTAERROR_NO_METHOD_STATUS;
> +
> +	return response_get_u64(resp, resp->num - 4);
> +}
> +
> +/* Parses and checks for errors */
> +static int parse_and_check_status(struct opal_dev *dev)
> +{
> +	struct opal_cmd *cmd;
> +	int error;
> +
> +	cmd = &dev->cmd;
> +	print_buffer(cmd->cmd, cmd->pos);
> +
> +	error = response_parse(cmd->resp, IO_BUFFER_LENGTH, &dev->parsed);
> +	if (error) {
> +		pr_err("%s: Couldn't parse response.\n", dev->disk_name);
> +		goto err_return;
> +	}
> +
> +	error = response_status(&dev->parsed);
> +	if (error)
> +		pr_err("%s: Response Status: %d\n", dev->disk_name,
> +		       error);
> +
> + err_return:
> +	return error;
> +}
> +
> +static void clear_opal_cmd(struct opal_cmd *cmd)
> +{
> +	cmd->pos = sizeof(struct opal_header);
> +	memset(cmd->cmd, 0, IO_BUFFER_LENGTH);
> +	cmd->cb = NULL;
> +	cmd->cb_data = NULL;
> +}
> +
> +static void start_opal_session_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +	u32 HSN, TSN;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		goto err_return;
> +
> +	HSN = response_get_u64(&dev->parsed, 4);
> +	TSN = response_get_u64(&dev->parsed, 5);
> +
> +	if (HSN == 0 && TSN == 0) {
> +		pr_err("%s: Couldn't authenticate session\n", dev->disk_name);
> +		error = -EPERM;
> +		goto err_return;
> +	}
> +
> +	dev->HSN = HSN;
> +	dev->TSN = TSN;
> +
> +err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +static int get_opal_key(struct opal_dev *dev)
> +{
> +	struct key *ukey = NULL;
> +	const u8 *tmpkey = NULL;
> +	size_t tmplen;
> +	int ret = 0;
> +
> +	if (dev->key_type == OPAL_KEY_PLAIN) {
> +		tmpkey = dev->key_name;
> +		tmplen = dev->key_name_len;
> +	} else if (dev->key_type == OPAL_KEY_KEYRING) {
> +		ukey = request_user_key(dev->key_name, &tmpkey, &tmplen);
> +		if (IS_ERR(ukey)) {
> +			pr_err("%s: Can't retrieve key: %ld\n", dev->disk_name,
> +			       PTR_ERR(ukey));
> +			return PTR_ERR(ukey);
> +		}
> +	} else {
> +		pr_err("Requested invalid key type: %d\n", dev->key_type);
> +		return -EINVAL;
> +	}
> +
> +	if (tmplen > OPAL_KEY_MAX) {
> +		pr_err("Requested key with invalid size: %zd\n", tmplen);
> +		ret = -EINVAL;
> +		goto err_exit;
> +	}
> +
> +	dev->key_len = tmplen;
> +	if (!memcpy(dev->key, tmpkey, tmplen)) {
> +		pr_err("Error when copying key");
> +		ret = -EFAULT;
> +		goto err_exit;
> +	}
> +
> +err_exit:
> +	key_put(ukey);
> +
> +	return 0;
> +}
> +
> +static void clean_opal_key(struct opal_dev *dev)
> +{
> +	memset(dev->key, 0, OPAL_KEY_MAX);
> +	dev->key_len = 0;
> +}
> +
> +static inline void clean_function_data(struct opal_dev *dev)
> +{
> +		dev->func_data = NULL;
> +		dev->num_func_data = 0;
> +}
> +
> +/* This is a generic continue fn.
> + * We use this when we don't care about the response data
> + * and simply want to check the status and continue.
> + */
> +static void generic_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +
> + err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}

How about:

static void generic_cont(int error, void *data)
{
	struct opal_dev *dev = data;

	if (!error)
		error = parse_and_check_status(dev);

	if (dev->oper_cb)
		dev->oper_cb(error, dev);
}

> +
> +static void end_session_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +
> +	dev->HSN = 0;
> +	dev->TSN = 0;
> +	generic_cont(error, data);
> +}
> +
> +static int finalize_and_send(struct opal_dev *dev, struct opal_cmd *cmd,
> +			     sec_cb cont)
> +{
> +	int ret;
> +
> +	ret = cmd_finalize(cmd, dev->HSN, dev->TSN);
> +	if (ret) {
> +		pr_err("%s: Error finalizing command buffer: %d\n",
> +		       dev->disk_name, ret);
> +		return ret;
> +	}
> +
> +	print_buffer(cmd->cmd, cmd->pos);
> +
> +	ret = opal_send_recv(dev, cont, dev);
> +	if (ret)
> +		pr_err("%s: Error running command: %d\n",
> +		       dev->disk_name, ret);
> +
> +	return ret;
> +}
> +
> +static int wait_for_cmd_completion(struct opal_completion *completion)
> +{
> +	wait_for_completion_interruptible(&completion->cmd_completion);
> +	return completion->completion_status;
> +}
> +
> +static int gen_key(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	memcpy(uid, dev->prev_data, min(sizeof(uid), dev->prev_d_len));
> +	method = OPALMETHOD[OPAL_GENKEY];
> +	kfree(dev->prev_data);
> +	dev->prev_data = NULL;
> +
> +	ret = test_and_add_token_va(cmd, "c2s 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building gen key command\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static void get_active_key_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +	const char *activekey;
> +	size_t keylen;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		goto err_return;
> +	keylen = response_get_string(&dev->parsed, 4, &activekey);
> +	if (!activekey) {
> +		pr_err("%s: Couldn't extract the Activekey from the response\n",
> +		       __func__);
> +		error = 0x0A;
> +		goto err_return;
> +	}
> +	dev->prev_data = kmemdup(activekey, keylen, GFP_KERNEL);
> +
> +	if (!dev->prev_data)
> +		error = -ENOMEM;
> +
> +	dev->prev_d_len = keylen;
> +
> +err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +static int get_active_key(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_GET];
> +
> +	ret = build_locking_range(uid, sizeof(uid), dev->lr);
> +	if (ret < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +
> +	ret = test_and_add_token_va(cmd, "c2s 6c 4c 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* startCloumn */
> +				    OPAL_TINY_UINT_10, /* ActiveKey */
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_04, /* endColumn */
> +				    OPAL_TINY_UINT_10, /* ActiveKey */
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building get active key command\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, get_active_key_cont);
> +}
> +
> +static int setup_locking_range(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	struct opal_user_lr_setup *setup;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +	ret = build_locking_range(uid, sizeof(uid), dev->lr);
> +	if (ret < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +	setup = dev->func_data[dev->state - 1];
> +
> +	ret = test_and_add_token_va(cmd, "c2s  4c 2cuc 2cuc 2cuc 2cu 4c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_VALUES,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* Range Start */
> +				    setup->range_start,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_04, /* Range Length */
> +				    setup->range_length,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_05, /* ReadLockEnabled */
> +				    !!setup->RLE,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_06, /* WriteLockEnabled */
> +				    !!setup->WLE,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building Setup Locking range command.\n",
> +		       dev->disk_name);
> +		return ret;
> +
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int start_adminsp_opal_session(struct opal_dev *dev,
> +				      enum OPAL_UID auth,
> +				      const char *key,
> +				      u8 key_len)
> +{
> +	const u8 *method, *smuid, *admin_sp, *hsa;
> +	struct opal_cmd *cmd;
> +	u32 HSN;
> +	int ret;
> +
> +	if (key == NULL && auth != OPAL_ANYBODY_UID) {
> +		pr_err("%s: Attempted to open ADMIN_SP Session without a Host" \
> +		       "Challenge, and not as the Anybody UID\n", __func__);
> +		return 1;
> +	}
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	set_comID(cmd, dev->comID);
> +	HSN = 0x41;
> +
> +	smuid = OPALUID[OPAL_SMUID_UID];
> +	method = OPALMETHOD[OPAL_STARTSESSION];
> +	admin_sp = OPALUID[OPAL_ADMINSP_UID];
> +
> +	ret = test_and_add_token_va(cmd, "c2s cusc",
> +				    OPAL_CALL,
> +				    smuid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +				    OPAL_STARTLIST,
> +				    HSN,
> +				    admin_sp, OPAL_UID_LENGTH,
> +				    OPAL_TINY_UINT_01);
> +	if (ret < 0) {
> +		pr_err("%s: Error building start adminsp session command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	switch (auth) {
> +	case OPAL_ANYBODY_UID:
> +		/* nothing left to do for anybody, just end and finalize */
> +		ret = test_and_add_token_va(cmd, "c",
> +					    OPAL_ENDLIST);
> +		break;
> +	case OPAL_SID_UID:
> +		hsa = OPALUID[OPAL_SID_UID];
> +		ret = test_and_add_token_va(cmd, "2c s 3c s 2c",
> +					    OPAL_STARTNAME,
> +					    OPAL_TINY_UINT_00, /* HostChallenge */
> +					    key, key_len,
> +					    OPAL_ENDNAME,
> +					    OPAL_STARTNAME,
> +					    OPAL_TINY_UINT_03, /* HostSignAuth */
> +					    hsa, OPAL_UID_LENGTH,
> +					    OPAL_ENDNAME,
> +					    OPAL_ENDLIST);
> +		break;
> +	default:
> +		pr_err("Cannot start Admin SP session with auth %d\n", auth);
> +		return 1;
> +	}
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building start adminsp session command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, start_opal_session_cont);
> +}
> +
> +static int start_anybodyASP_opal_session(struct opal_dev *dev)
> +{
> +	return start_adminsp_opal_session(dev, OPAL_ANYBODY_UID, NULL, 0);
> +}
> +
> +static int start_SIDASP_opal_session(struct opal_dev *dev)
> +{
> +	int ret;
> +	const u8 *key = dev->prev_data;
> +
> +	if (!key)
> +		ret = start_adminsp_opal_session(dev, OPAL_SID_UID, dev->key,
> +						 dev->key_len);
> +	else {
> +		ret = start_adminsp_opal_session(dev, OPAL_SID_UID, key,
> +						 dev->prev_d_len);
> +		kfree(key);
> +		dev->prev_data = NULL;
> +	}
> +	return ret;
> +}
> +
> +static int start_lockingsp_opal_session(struct opal_dev *dev,
> +					enum OPAL_UID auth, const u8 *key,
> +					u8 key_len)
> +{
> +
> +	const u8 *method, *smuid, *locking_sp, *hsa;
> +	struct opal_cmd *cmd;
> +	size_t klen = key_len;
> +	u32 HSN;
> +	int ret;
> +
> +	if (key == NULL) {
> +		pr_err("Cannot start Locking SP session without a key\n");
> +		return -EINVAL;
> +	}
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	set_comID(cmd, dev->comID);
> +	HSN = 0x41;
> +
> +	smuid = OPALUID[OPAL_SMUID_UID];
> +	method = OPALMETHOD[OPAL_STARTSESSION];
> +	locking_sp = OPALUID[OPAL_LOCKINGSP_UID];
> +	hsa = OPALUID[auth];
> +
> +	ret = test_and_add_token_va(cmd, "c2s cusc 2csc 2csc c",
> +				    OPAL_CALL,
> +				    smuid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    HSN,
> +				    locking_sp, OPAL_UID_LENGTH,
> +				    OPAL_TINY_UINT_01,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_00, /* HostChallenge */
> +				    key, klen,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* Host Sign Authority */
> +				    hsa, OPAL_UID_LENGTH,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building start adminsp session command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +	return finalize_and_send(dev, cmd, start_opal_session_cont);
> +}
> +
> +static inline int start_admin1LSP_opal_session(struct opal_dev *dev)
> +{
> +	return start_lockingsp_opal_session(dev, OPAL_ADMIN1_UID,
> +					    dev->key, dev->key_len);
> +}
> +
> +static int start_auth_opal_session(struct opal_dev *dev)
> +{
> +	const u8 *method, *smuid, *locking_sp;
> +	u8 lk_ul_user[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	u32 HSN;
> +	int ret;
> +	struct opal_user_info *uinfo;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	set_comID(cmd, dev->comID);
> +
> +	HSN = 0x41;
Can we #define this; it's used a few other places and is magicky

> +
> +	uinfo = dev->func_data[dev->state - 1];
> +
> +	smuid = OPALUID[OPAL_SMUID_UID];
> +	method = OPALMETHOD[OPAL_STARTSESSION];
> +	locking_sp = OPALUID[OPAL_LOCKINGSP_UID];
> +
> +	if (uinfo->SUM) {
> +		ret = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
> +					 dev->lr);
> +		if (ret < 0) {
> +			pr_err("%s: Can't build locking user\n",
> +			       dev->disk_name);
> +			return ret;
> +		}
> +	} else if (uinfo->who != OPAL_ADMIN1 && !uinfo->SUM) {
> +		ret = build_locking_user(lk_ul_user, sizeof(lk_ul_user),
> +					 uinfo->who - 1);
> +		if (ret < 0) {
> +			pr_err("%s: Can't build locking user\n",
> +			       dev->disk_name);
> +			return ret;
> +		}
> +	} else
> +		memcpy(lk_ul_user, OPALUID[OPAL_ADMIN1_UID], OPAL_UID_LENGTH);
> +
> +
> +	ret = test_and_add_token_va(cmd, "c2s cus3cs3c s 2c",
> +				    OPAL_CALL,
> +				    smuid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    HSN,
> +				    locking_sp, OPAL_UID_LENGTH,
> +				    OPAL_TINY_UINT_01,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_00,
> +				    dev->key, dev->key_len,
> +				    OPAL_ENDNAME,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03,
> +
> +				    lk_ul_user, OPAL_UID_LENGTH,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building STARTSESSION command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, start_opal_session_cont);
> +}
> +
> +static int revert_tper(struct opal_dev *dev)
> +{
> +	const u8 *method, *smuid;
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	set_comID(cmd, dev->comID);
> +
> +	smuid = OPALUID[OPAL_ADMINSP_UID];
> +	method = OPALMETHOD[OPAL_REVERT];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 2c",
> +				    OPAL_CALL,
> +				    smuid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +				    OPAL_STARTLIST,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building REVERT TPER command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int internal_activate_user(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	int ret;
> +	struct opal_activate_user *act;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	act = dev->func_data[dev->state - 1];
> +
> +	memcpy(uid, OPALUID[OPAL_USER1_UID], OPAL_UID_LENGTH);
> +	uid[7] = act->who.who;
> +
> +	method = OPALMETHOD[OPAL_SET];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 3c c 4c 3c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_01, /* Values */
> +
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_05, /* Enabled */
> +				    OPAL_TINY_UINT_01, /* True */
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building Activate UserN command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int erase_locking_range(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_ERASE];
> +
> +	if (build_locking_range(uid, sizeof(uid), dev->lr) < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +
> +	ret = test_and_add_token_va(cmd, "c2s 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building Erase Locking Range Cmmand.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int set_mbr_done(struct opal_dev *dev)
> +{
> +	const u8 *method, *uid;
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state - 1];
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +	uid = OPALUID[OPAL_MBRCONTROL];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 3c 6c 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_VALUES,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_02, /* Done */
> +				    mbr_done_tf,       /* Done T or F */
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error Building set MBR Dont/Not done command\n",
s/Dont/Done/ ?


> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int set_mbr_enable_disable(struct opal_dev *dev)
> +{
> +	const u8 *method, *uid;
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	u8 mbr_en_dis = *(u8 *)dev->func_data[dev->state - 1];
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +	uid = OPALUID[OPAL_MBRCONTROL];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 3c 6c 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_VALUES,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_01, /* Enable */
> +				    mbr_en_dis,        /* Enable or Disable */
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error Building set MBR Dont/Not done command\n",
s/Dont/Done/ ?


> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int set_new_pw(struct opal_dev *dev)
> +{
> +	const u8 *method;
> +	u8 cpin_uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	int ret;
> +	struct opal_new_pw *pw;
> +	size_t key_len;
> +	u8 *key;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	pw = dev->func_data[dev->state - 1];
> +	key = pw->new_pin.key;
> +	key_len = pw->new_pin.key_len;
> +	memcpy(cpin_uid, OPALUID[OPAL_C_PIN_ADMIN1], OPAL_UID_LENGTH);
> +
> +	if (pw->user_for_pw != OPAL_ADMIN1) {
> +		cpin_uid[5] = 0x03;
> +		if (pw->who.SUM)
> +			cpin_uid[7] = pw->new_pin.lr + 1;
> +		else
> +			cpin_uid[7] = pw->user_for_pw;
> +	}
> +
> +	method = OPALMETHOD[OPAL_SET];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 3c 3cs2c 2c",
> +				    OPAL_CALL,
> +				    cpin_uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_01, /* Values */
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* PIN */
> +				    key, key_len,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building SET AMIN1 PIN command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int set_sid_cpin_pin(struct opal_dev *dev)
> +{
> +	const u8 *method, *cpin_uid;
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	cpin_uid = OPALUID[OPAL_C_PIN_SID];
> +	method = OPALMETHOD[OPAL_SET];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 2c 4cs2c 2c",
> +				    OPAL_CALL,
> +				    cpin_uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +
> +				    OPAL_TINY_UINT_01, /* Values */
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* PIN */
> +				    dev->key, dev->key_len,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building SET CPIN PIN command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static void query_locking_range_cont(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		goto err_return;
> +
> +	dev->start = response_get_u64(&dev->parsed, 4);
> +	dev->length = response_get_u64(&dev->parsed, 8);
> +
> +err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +static int query_locking_range(struct opal_dev *dev)
> +{
> +	u8 lr_buffer[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	const u8 *method;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	method = OPALMETHOD[OPAL_GET];
> +
> +	if (build_locking_range(lr_buffer, sizeof(lr_buffer), dev->lr) < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +
> +	set_comID(cmd, dev->comID);
> +
> +	ret = test_and_add_token_va(cmd, "c2s 12c",
> +				    OPAL_CALL,
> +				    lr_buffer, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_STARTCOLUMN,
> +				    OPAL_RANGESTART,
> +				    OPAL_ENDNAME,
> +				    OPAL_STARTNAME,
> +				    OPAL_ENDCOLUMN,
> +				    OPAL_RANGELENGTH,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building GET Locking Range command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, query_locking_range_cont);
> +}
> +
> +static int add_user_to_lr(struct opal_dev *dev)
> +{
> +	u8 lr_buffer[OPAL_UID_LENGTH];
> +	u8 user_uid[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	const u8 *method;
> +	struct opal_lock_unlock *lkul;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +
> +	lkul = dev->func_data[dev->state - 1];
> +
> +	memcpy(lr_buffer, OPALUID[OPAL_LOCKINGRANGE_ACE_RDLOCKED],
> +	       OPAL_UID_LENGTH);
> +
> +	if (lkul->l_state == OPAL_RW)
> +		memcpy(lr_buffer, OPALUID[OPAL_LOCKINGRANGE_ACE_WRLOCKED],
> +		       OPAL_UID_LENGTH);
> +
> +	lr_buffer[7] = dev->lr;
> +
> +	memcpy(user_uid, OPALUID[OPAL_USER1_UID], OPAL_UID_LENGTH);
> +	user_uid[7] = lkul->authority.who;
> +
> +	ret = test_and_add_token_va(cmd, "c2s 3c 3c 2c 2sc c2sc cs2c 5c",
> +				    OPAL_CALL,
> +				    lr_buffer, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_01, /* Values */
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* BooleanExpr */
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +
> +				    OPALUID[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
> +				    OPAL_UID_LENGTH_HALF,
> +				    user_uid, OPAL_UID_LENGTH,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPALUID[OPAL_HALF_UID_AUTHORITY_OBJ_REF],
> +				    OPAL_UID_LENGTH_HALF,
> +				    user_uid, OPAL_UID_LENGTH,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPALUID[OPAL_HALF_UID_BOOLEAN_ACE],
> +				    OPAL_UID_LENGTH_HALF,
> +				    OPAL_TINY_UINT_01,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building add user to locking range command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static int lock_unlock_locking_range(struct opal_dev *dev)
> +{
> +	u8 lr_buffer[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	const u8 *method;
> +	struct opal_lock_unlock *lkul;
> +	int ret;
> +	u8 read_locked = 1, write_locked = 1;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +	lkul = dev->func_data[dev->state - 1];
> +	if (build_locking_range(lr_buffer, sizeof(lr_buffer), dev->lr) < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +
> +	switch (lkul->l_state) {
> +	case OPAL_RO:
> +		read_locked = 0;
> +		write_locked = 1;
> +		break;
> +	case OPAL_RW:
> +		read_locked = 0;
> +		write_locked = 0;
> +		break;
> +	case OPAL_LK:
> +		/* vars are initalized to locked */
> +		break;
> +	default:
> +		pr_err("Tried to set an invalid locking state... returning to uland\n");
> +		return 1;
> +	}
> +
> +	ret = test_and_add_token_va(cmd, "c2sc 3c 4c 4c 3c",
> +				    OPAL_CALL,
> +				    lr_buffer, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_VALUES,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_READLOCKED,
> +				    read_locked,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_WRITELOCKED,
> +				    write_locked,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building SET command.\n", dev->disk_name);
> +		return ret;
> +	}
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +
> +static int lock_unlock_locking_range_SUM(struct opal_dev *dev)
> +{
> +	u8 lr_buffer[OPAL_UID_LENGTH];
> +	struct opal_cmd *cmd;
> +	const u8 *method;
> +	struct opal_lock_unlock *lkul;
> +	int ret;
> +	u8 read_locked = 1, write_locked = 1;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	method = OPALMETHOD[OPAL_SET];
> +	lkul = dev->func_data[dev->state - 1];
> +	if (build_locking_range(lr_buffer, sizeof(lr_buffer), dev->lr) < 0) {
> +		pr_err("%s: Can't build locking range\n", dev->disk_name);
> +		return -EINVAL;
> +	}
> +
> +	switch (lkul->l_state) {
> +	case OPAL_RO:
> +		read_locked = 0;
> +		write_locked = 1;
> +		break;
> +	case OPAL_RW:
> +		read_locked = 0;
> +		write_locked = 0;
> +		break;
> +	case OPAL_LK:
> +		/* vars are initalized to locked */
> +		break;
> +	default:
> +		pr_err("Tried to set an invalid locking state.\n");
> +		return 1;
> +	}
> +
> +	ret = test_and_add_token_va(cmd, "c2sc 3c 4c 4c 4c 4c 3c",
> +				    OPAL_CALL,
> +				    lr_buffer, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_VALUES,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_READLOCKENABLED,
> +				    OPAL_TRUE,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_WRITELOCKENABLED,
> +				    OPAL_TRUE,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_READLOCKED,
> +				    read_locked,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_WRITELOCKED,
> +				    write_locked,
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST);
> +	if (ret < 0) {
> +		pr_err("%s: Error building SET command.\n", dev->disk_name);
> +		return ret;
> +	}
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +int activate_lsp(struct opal_dev *dev)
> +{
> +	u8 user_lr[OPAL_UID_LENGTH];
> +	const u8 *method, *uid;
> +	struct opal_cmd *cmd;
> +	int ret;
> +	size_t uint_3 = 0x83;
> +
> +	cmd = &dev->cmd;
> +
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	uid = OPALUID[OPAL_LOCKINGSP_UID];
> +	method = OPALMETHOD[OPAL_ACTIVATE];
> +
> +	ret = test_and_add_token_va(cmd, "c2s",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH);
> +	if (ret < 0) {
> +		pr_err("%s: Error building Activate LockingSP command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +	/* Activating as SUM */
> +	if (dev->lr > 0) {
> +		ret = build_locking_range(user_lr, sizeof(user_lr), dev->lr);
> +		if (ret < 0) {
> +			pr_err("%s: Can't build locking user\n",
> +			       dev->disk_name);
> +			return ret;
> +		}
> +		test_and_add_token_va(cmd, "2c 4c csc 2c",
> +				      OPAL_STARTLIST,
> +				      OPAL_STARTNAME,
> +
> +				      uint_3,
> +				      OPAL_TINY_UINT_06,
> +				      OPAL_TINY_UINT_00,
> +				      OPAL_TINY_UINT_00,
> +
> +				      OPAL_STARTLIST,
> +				      user_lr, OPAL_UID_LENGTH,
> +				      OPAL_ENDLIST,
> +
> +				      OPAL_ENDNAME,
> +				      OPAL_ENDLIST);
> +	} else /* Actiave Normal Mode */
> +		ret = test_and_add_token_va(cmd, "2c",
> +					    OPAL_STARTLIST,
> +					    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building Activate LockingSP command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, generic_cont);
> +}
> +
> +static void get_lsp_lifecycle_cont(int error, void *data)
> +{
> +
> +	struct opal_dev *dev = data;
> +	u8 lc_status;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		goto err_return;
> +
> +	lc_status = response_get_u64(&dev->parsed, 4);
> +	/* 0x08 is Manufacured Inactive */
> +	/* 0x09 is Manufactured */
> +	if (lc_status != 0x08) {
> +		pr_err("%s: Couldn't determine the status of the Lifcycle state\n",
> +		       dev->disk_name);
> +		error = -ENODEV;
> +	}
> +
> +err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +/* Determine if we're in the Manufactured Inactive or Active state */
> +int get_lsp_lifecycle(struct opal_dev *dev)
> +{
> +	struct opal_cmd *cmd;
> +	const u8 *method, *uid;
> +	int ret;
> +
> +	cmd = &dev->cmd;
> +
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	uid = OPALUID[OPAL_LOCKINGSP_UID];
> +	method = OPALMETHOD[OPAL_GET];
> +
> +	ret = test_and_add_token_va(cmd, "c2s 2c 4c 4c 2c",
> +				    OPAL_CALL,
> +				    uid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTLIST,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* Start Column */
> +				    OPAL_TINY_UINT_06, /* Lifcycle Column */
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_04, /* End Column */
> +				    OPAL_TINY_UINT_06, /* Lifecycle Column */
> +				    OPAL_ENDNAME,
> +
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error Building GET Lifecycle Status command\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, get_lsp_lifecycle_cont);
> +}
> +
> +static void get_msid_cpin_pin_cont(int error, void *data)
> +{
> +	const char *msid_pin;
> +	struct opal_dev *dev = data;
> +	size_t strlen;
> +
> +	if (error)
> +		goto err_return;
> +
> +	error = parse_and_check_status(dev);
> +	if (error)
> +		goto err_return;
> +
> +	strlen = response_get_string(&dev->parsed, 4, &msid_pin);
> +	if (!msid_pin) {
> +		pr_err("%s: Couldn't extract PIN from response\n", __func__);
> +		error = 1;
> +		goto err_return;
> +	}
> +
> +	dev->prev_data = kmemdup(msid_pin, strlen, GFP_KERNEL);
> +	if (!dev->prev_data)
> +		error = -ENOMEM;
> +
> +	dev->prev_d_len = strlen;
> +
> + err_return:
> +	if (dev->oper_cb)
> +		dev->oper_cb(error, dev);
> +}
> +
> +static int get_msid_cpin_pin(struct opal_dev *dev)
> +{
> +	const u8 *method, *smuid;
> +	int ret;
> +	struct opal_cmd *cmd;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +	set_comID(cmd, dev->comID);
> +
> +	smuid = OPALUID[OPAL_C_PIN_MSID];
> +	method = OPALMETHOD[OPAL_GET];
> +
> +	ret = test_and_add_token_va(cmd, "c 2s 12c",
> +				    OPAL_CALL,
> +
> +				    smuid, OPAL_UID_LENGTH,
> +				    method, OPAL_METHOD_LENGTH,
> +
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTLIST,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_03, /* Sart Column */
> +				    OPAL_TINY_UINT_03, /* PIN */
> +				    OPAL_ENDNAME,
> +				    OPAL_STARTNAME,
> +				    OPAL_TINY_UINT_04, /* End Column */
> +				    OPAL_TINY_UINT_03, /* PIN */
> +				    OPAL_ENDNAME,
> +				    OPAL_ENDLIST,
> +				    OPAL_ENDLIST);
> +
> +	if (ret < 0) {
> +		pr_err("%s: Error building Get MSID CPIN PIN command.\n",
> +		       dev->disk_name);
> +		return ret;
> +	}
> +
> +	return finalize_and_send(dev, cmd, get_msid_cpin_pin_cont);
> +}
> +
> +static void unlock_suspend_final(int error, void *data)
> +{
> +	struct opal_dev *dev = data;
> +
> +	dev->resume_from_suspend = false;
> +	dev->resume_data = NULL;
> +	dev->func_data = NULL;
> +	dev->bdev = NULL;
> +}
> +
> +static int build_end_opal_session(struct opal_dev *dev)
> +{
> +	struct opal_cmd *cmd;
> +
> +	cmd = &dev->cmd;
> +	clear_opal_cmd(cmd);
> +
> +	set_comID(cmd, dev->comID);
> +	return test_and_add_token_u8(cmd, OPAL_ENDOFSESSION);
> +}
> +
> +static int end_opal_session(struct opal_dev *dev)
> +{
> +	if (build_end_opal_session(dev) < 0)
> +		return -1;
> +	return finalize_and_send(dev, &dev->cmd, end_session_cont);
> +}
Any reason we cant:

int ret = build_...
if (ret < 0)
	return ret;


> +
> +static struct opal_dev *find_opal_dev(struct block_device *bdev, u8 lr)
> +{
> +	struct opal_dev *iter, *opal_dev = NULL;
> +
> +	list_for_each_entry(iter, &opal_list, node) {
> +		if (strncmp(iter->disk_name, bdev->bd_disk->disk_name,
> +			    DISK_NAME_LEN))
> +			continue;
> +		if (iter->lr == lr) {
> +			opal_dev = iter;
> +			break;
> +		}
> +	}
> +
> +	return opal_dev;
> +}
> +
> +static int update_opal_dev(struct opal_dev *old_dev, struct opal_dev *new_dev)
> +{
> +	if (!atomic_add_unless(&old_dev->in_use, 1, 1)) {
> +		pr_err("%s: dev was in use\n", __func__);
> +		return -EBUSY;
> +	}
> +
> +	old_dev->key_name_len = new_dev->key_name_len;
> +	if (!memcpy(old_dev->key_name, new_dev->key_name, old_dev->key_name_len)) {
> +		pr_err("%s: Error updating device:\n", old_dev->disk_name);
> +		return -EFAULT;
> +	}
> +
> +	if (!strncpy(old_dev->disk_name, new_dev->disk_name, DISK_NAME_LEN)) {
> +		pr_err("%s: Error registering device: copying disk name\n",
> +		       old_dev->disk_name);
> +		return -EFAULT;
> +	}
> +
> +	old_dev->comID = new_dev->comID;
> +	old_dev->start = new_dev->start;
> +	old_dev->length = new_dev->length;
> +	old_dev->align = new_dev->align;
> +	old_dev->lowest_lba = new_dev->lowest_lba;
> +	old_dev->bdev = NULL;
> +	old_dev->final_cb = new_dev->final_cb;
> +	old_dev->final_cb_data = new_dev->final_cb_data;
> +	old_dev->oper_cb = new_dev->oper_cb;
> +	old_dev->state = new_dev->state;
> +	old_dev->funcs = new_dev->funcs;
> +
> +	kfree(old_dev->completion);
> +	clean_function_data(old_dev);
> +
> +	old_dev->completion = new_dev->completion;
> +
> +	/*
> +	 * Won't be able to auto unlock this locking range based on block
> +	 * requestes.
> +	 */
> +	if (old_dev->length == 0)
> +		pr_warn("%s: Missing block information for locking range %d\n",
> +			old_dev->disk_name, old_dev->lr);
> +
> +	return 0;
> +}
> +
> +int opal_register_cont(struct opal_dev *new_dev)
> +{
> +	struct opal_dev *old_dev;
> +	unsigned long flags;
> +	int error = 0;
> +
> +	spin_lock_irqsave(&list_spinlock, flags);
> +
> +	old_dev = find_opal_dev(new_dev->bdev, new_dev->lr);
> +	if (!old_dev) {
> +		list_add_tail(&new_dev->node, &opal_list);
> +		old_dev = new_dev;
> +	} else {
> +		if (old_dev == new_dev)
> +			error = 0;
> +		else {
> +			error = update_opal_dev(old_dev, new_dev);
> +			clean_opal_key(new_dev);
> +			kfree(new_dev);
> +		}
> +	}
> +
> +	if (error)
> +		list_del(&old_dev->node);
> +
> +	spin_unlock_irqrestore(&list_spinlock, flags);
> +
> +	if (!error)
> +		pr_info("%s: Registered key for locking range: %d\n",
> +			old_dev->disk_name, old_dev->lr);
> +
> +	if (old_dev->oper_cb)
> +		old_dev->oper_cb(error, old_dev);
> +
> +	return 0;
> +}
> +
> +static void next(int error, struct opal_dev *dev)
> +{
> +	opal_step func = dev->funcs[dev->state];
> +	void *cb_data = dev->final_cb_data;
> +	sec_cb *cb = dev->final_cb;
> +	bool done = false;
> +
> +
> +	if (error || !func) {
> +		done = true;
> +		goto next_exit;
> +	}
> +	dev->state++;
> +	dev->oper_cb = next;
> +	error = func(dev);
> + next_exit:
> +	if (error) {
> +		pr_err("%s: Error on step function: %d with error %d: %s\n",
> +		       dev->disk_name, dev->state, error,
> +		       opal_error_to_human(error));
> +
> +
> +		atomic_dec(&dev->in_use);
> +		if (dev->error_cb) {
> +			dev->error_cb(dev->error_cb_data);
> +			return;
> +		}
> +		if (cb)
> +			cb(error, cb_data);
> +
> +		dev->completion->completion_status = error;
> +		complete(&dev->completion->cmd_completion);
> +	} else if (!error && done) {
> +		atomic_dec(&dev->in_use);
> +		if (cb)
> +			cb(error, cb_data);
> +		dev->completion->completion_status = error;
> +		complete(&dev->completion->cmd_completion);
> +	}
> +}
> +
> +const opal_step error_end_session[] = {
> +	end_opal_session,
> +	NULL,
> +};
> +static int end_opal_session_error(struct opal_dev *dev)
> +{
> +
> +	dev->funcs = error_end_session;
> +	dev->state = 0;
> +	dev->error_cb = NULL;
> +	next(0, dev);
> +	return 0;
> +}
> +
> +static struct opal_dev *alloc_opal_dev(struct block_device *bdev, u8 lr)
> +{
> +	struct opal_dev *opal_dev;
> +	struct request_queue *q;
> +	unsigned long dma_align;
> +	const char *disk_name;
> +	struct opal_cmd *cmd;
> +	int ret;
> +
> +	opal_dev = kzalloc(sizeof(*opal_dev), GFP_KERNEL);
> +	if (!opal_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	opal_dev->bdev = bdev;
> +	opal_dev->lr = lr;
> +	cmd = &opal_dev->cmd;
> +	cmd->cmd = cmd->cmd_buf;
> +	cmd->resp = cmd->resp_buf;
> +
> +	disk_name = bdev->bd_disk->disk_name;
> +	if (!strncpy(opal_dev->disk_name, disk_name, DISK_NAME_LEN)) {
> +		pr_err("%s: Error registering device: copying disk name\n",
> +		       disk_name);
> +		ret = -EFAULT;
> +		goto err_free_dev;
> +	}
> +
> +	q = bdev->bd_queue;
> +	dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
> +	cmd->cmd = (u8 *)round_up((uintptr_t)cmd->cmd, dma_align);
> +	cmd->resp = (u8 *)round_up((uintptr_t)cmd->resp, dma_align);
> +
> +	INIT_LIST_HEAD(&opal_dev->node);
> +	atomic_set(&opal_dev->in_use, 1);
> +
> +	opal_dev->completion = kzalloc(sizeof(*opal_dev->completion),
> +				       GFP_KERNEL);
> +
> +	if (!opal_dev->completion)
> +		goto err_free_dev;
> +
> +	init_completion(&opal_dev->completion->cmd_completion);
> +	opal_dev->completion->completion_status = 0;
> +	opal_dev->state = 0;
> +
> +	return opal_dev;
> +
> +err_free_dev:
> +	kfree(opal_dev);
> +	return ERR_PTR(ret);
> +}
> +
> +int opal_register(struct block_device *bdev, struct opal_key *key_cmd,
> +		  const opal_step *funcs)
> +{
> +	struct opal_dev *new_dev = NULL;
> +	u8 key_len = key_cmd->key_len;
> +	u8 lr = key_cmd->lr;
> +	struct opal_completion *completion;
> +	int ret;
> +
> +	new_dev = alloc_opal_dev(bdev, lr);
> +	if (IS_ERR(new_dev)) {
> +		pr_err("%s: Error registering device: allocation\n",
> +		       bdev->bd_disk->disk_name);
> +		return PTR_ERR(new_dev);
> +	}
> +
> +	if (!memcpy(new_dev->key_name, key_cmd->key, key_len)) {
> +		pr_err("%s: Error registering key: couldn't copy key\n",
> +		       new_dev->disk_name);
> +		return -EFAULT;
> +	}
> +
> +	new_dev->key_name_len = key_len;
> +	new_dev->key_type = key_cmd->key_type;
> +	ret = get_opal_key(new_dev);
> +	if (ret) {
> +		pr_err("%s: Couldn't get key: %d\n", new_dev->disk_name, ret);
> +		return ret;
> +	}
> +
> +	new_dev->funcs = funcs;
> +
> +	new_dev->state = 0;
> +	completion = new_dev->completion;
> +	next(0, new_dev);
> +
> +	return wait_for_cmd_completion(completion);
> +}
> +
> +static struct opal_dev *get_registered_opal_dev(struct block_device *bdev,
> +						u8 lr)
> +{
> +	const char *diskname = bdev->bd_disk->disk_name;
> +	struct opal_dev *iter, *dev = NULL;
> +	unsigned long flags;
> +	bool in_use = false;
> +
> +	spin_lock_irqsave(&list_spinlock, flags);
> +	list_for_each_entry(iter, &opal_list, node) {
> +		if (strncmp(iter->disk_name, diskname, DISK_NAME_LEN))
> +			continue;
> +		if (iter->lr == lr) {
> +			dev = iter;
> +			if (!atomic_add_unless(&iter->in_use, 1, 1)) {
> +				dev = NULL;
> +				in_use = true;
> +			}
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&list_spinlock, flags);
> +
> +	if (!dev)
> +		return NULL;
> +
> +	dev->bdev = bdev;
> +	return dev;
> +}
> +
> +/* Free up the Opal dev and its keys during two scenarios:
> + *
> + * 1) When a command is complete that no longer requires
> + *    the opal dev to be around.
> + * 2) When a command, including Opal Save fails we clean
> + *    and free the opal dev.
> + *
> + *    If we find the opal dev structure in the list of
> + *    saved passwords we will *not* remove it.
> + */
> +static void remove_and_clean_opal_dev(struct opal_dev *dev)
> +{
> +	struct opal_dev *iter;
> +	bool found = false;
> +
> +	spin_lock(&list_spinlock);
> +	list_for_each_entry(iter, &opal_list, node) {
> +		if (iter == dev) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock(&list_spinlock);
> +	if (!found) {
> +		clean_opal_key(dev);
> +		clean_function_data(dev);
> +		kfree(dev);
> +	}
> +}
> +
> +static struct opal_dev *get_or_create_opal_dev(struct block_device *bdev,
> +					       u8 lr, bool use_new)
> +{
> +	struct opal_dev *dev;
> +
> +	if (use_new)
> +		return alloc_opal_dev(bdev, lr);
> +
> +	dev = get_registered_opal_dev(bdev, lr);
> +	if (!dev) {
> +		dev = alloc_opal_dev(bdev, lr);
> +		if (!dev)
> +			return NULL;
No need for this check when you already return dev


> +	}
> +	return dev;
> +}
Instead, how about:
static struct opal_dev *get_or_create_opal_dev(struct block_device *bdev,
					       u8 lr, bool use_new)
{
	struct opal_dev *dev = NULL;

	if (!use_new)
		dev = get_registered_opal_dev(bdev, lr);

	if (!dev)
		dev = alloc_opal_dev(bdev, lr);

	return dev;
}


> +
> +static struct opal_completion *setup_opal_dev(struct block_device *bdev,
> +					      struct opal_dev *dev,
> +					      const opal_step *funcs,
> +					      struct opal_key *key)
> +{
> +	int ret;
> +
> +	dev->bdev = bdev;
> +	dev->state = 0;
> +	dev->funcs = funcs;
> +	dev->TSN = 0;
> +	dev->HSN = 0;
> +	dev->final_cb = NULL;
> +	dev->final_cb_data = NULL;
> +	dev->lr = key->lr;
> +	dev->error_cb = end_opal_session_error;
> +	dev->error_cb_data = dev;
> +
> +	if (key) {
> +		memcpy(dev->key_name, key->key, key->key_len);
> +		dev->key_name_len = key->key_len;
> +		dev->key_type = key->key_type;
> +
> +		ret = get_opal_key(dev);
> +		if (ret) {
> +			kfree(dev->completion);
> +			pr_err("%s: Couldn't get key: %d\n",
> +			       dev->disk_name, ret);
> +			return ERR_PTR(ret);
> +		}
> +	}
> +	dev->func_data = NULL;
> +	dev->completion->completion_status = 0;
> +
> +	return dev->completion;
> +}
> +
> +static int internal_setup_lr(struct block_device *bdev,
> +			     struct opal_user_lr_setup *setup)
> +{
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	void *data[3] = { NULL };
> +	const opal_step lr_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		setup_locking_range,
> +		get_active_key,
> +		gen_key,
> +		end_opal_session,
> +		NULL,
> +	};
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, setup->key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	completion = setup_opal_dev(bdev, dev, lr_funcs, &setup->key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->func_data = data;
> +	dev->num_func_data = 3;
> +	dev->func_data[1] = &setup->who;
> +	dev->func_data[2] = setup;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +int opal_revert(struct block_device *bdev, struct opal_key *key)
> +{
> +	const opal_step revert_funcs[] = {
> +		opal_discovery0,
> +		start_SIDASP_opal_session,
> +		revert_tper, /* controller will terminate session */
> +		NULL,
> +	};
> +
> +	return opal_register(bdev, key, revert_funcs);
> +}
> +
> +int activate_user(struct block_device *bdev, struct opal_activate_user *act)
> +{
> +	const opal_step act_funcs[] = {
> +		opal_discovery0,
> +		start_admin1LSP_opal_session,
> +		internal_activate_user,
> +		end_opal_session,
> +		NULL
> +	};
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	void *data[3] = { NULL };
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, act->key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	completion = setup_opal_dev(bdev, dev, act_funcs, &act->key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 3;
> +	dev->func_data = data;
> +	dev->func_data[1] = act;
> +	dev->func_data[2] = act;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +int opal_set_pw(struct block_device *bdev, struct opal_new_pw *pw)
> +
> +{
> +	const opal_step pw_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		set_new_pw,
> +		end_opal_session,
> +		NULL
> +	};
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	void *data[3] = { NULL };
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, pw->current_pin.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	completion = setup_opal_dev(bdev, dev, pw_funcs, &pw->current_pin);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 3;
> +	dev->func_data = data;
> +	dev->func_data[1] = (void *) &pw->who;
> +	dev->func_data[2] = (void *) pw;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +int opal_act_lsp_int(struct block_device *bdev, struct opal_key *key,
> +		     const opal_step *funcs)
> +{
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, key->lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +	completion = setup_opal_dev(bdev, dev, funcs, key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +
> +static int opal_save_internal(struct block_device *bdev,
> +			      struct opal_lock_unlock *lk)
> +{
> +	void *func_data[3] = { NULL };
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	const opal_step _auth_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		query_locking_range,
> +		end_opal_session,
> +		opal_register_cont,
> +		NULL
> +	};
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, lk->key.lr, false);
> +	if (!dev)
> +		return -ENOMEM;
> +	completion = setup_opal_dev(bdev, dev, _auth_funcs, &lk->key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 3;
> +	dev->func_data = func_data;
> +	dev->func_data[1] = &lk->authority;
> +	dev->lkul = *lk;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +static int add_user_lr_internal(struct block_device *bdev,
> +				struct opal_lock_unlock *lk)
> +{
> +	void *func_data[3] = { NULL };
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	const opal_step funcs[] = {
> +		opal_discovery0,
> +		start_admin1LSP_opal_session,
> +		add_user_to_lr,
> +		end_opal_session,
> +		NULL
> +	};
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, lk->key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +	completion = setup_opal_dev(bdev, dev, funcs, &lk->key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 3;
> +	dev->func_data = func_data;
> +	dev->func_data[2] = lk;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +static int lock_unlock_internal(struct block_device *bdev,
> +				struct opal_lock_unlock *lk)
> +{
> +	void *func_data[3] = { NULL };
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +
> +	const opal_step ulk_funcs_SUM[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		lock_unlock_locking_range_SUM,
> +		end_opal_session,
> +		NULL
> +	};
> +	const opal_step _unlock_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		lock_unlock_locking_range,
> +		end_opal_session,
> +		NULL
> +	};
> +	int ret;
> +
> +	dev = get_or_create_opal_dev(bdev, lk->key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	if (lk->authority.SUM)
> +		completion = setup_opal_dev(bdev, dev, ulk_funcs_SUM, &lk->key);
> +	else
> +		completion = setup_opal_dev(bdev, dev, _unlock_funcs, &lk->key);
> +
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 3;
> +	dev->func_data = func_data;
> +	dev->func_data[1] = &lk->authority;
> +	dev->func_data[2] = lk;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +
> +int opal_erase_locking_range(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	struct opal_key k;
> +	int ret;
> +	const opal_step erase_funcs[] = {
> +		opal_discovery0,
> +		start_admin1LSP_opal_session,
> +		erase_locking_range,
> +		end_opal_session,
> +		NULL,
> +	};
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&k, key->opal, sizeof(*key->opal)))
> +		return -EFAULT;
> +
> +	dev = get_or_create_opal_dev(bdev, k.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	completion = setup_opal_dev(bdev, dev, erase_funcs, &k);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +}
> +EXPORT_SYMBOL(opal_erase_locking_range);
> +
> +int opal_enable_disable_shadow_mbr(struct block_device *bdev,
> +				   struct sed_key *key)
> +{
> +	void *func_data[6] = { NULL };
> +	struct opal_mbr_data mbr;
> +	struct opal_dev *dev;
> +	struct opal_completion *completion;
> +	const opal_step mbr_funcs[] = {
> +		opal_discovery0,
> +		start_admin1LSP_opal_session,
> +		set_mbr_done,
> +		end_opal_session,
> +		start_admin1LSP_opal_session,
> +		set_mbr_enable_disable,
> +		end_opal_session,
> +		NULL,
> +	};
> +	int ret;
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&mbr, key->opal_mbr, sizeof(*key->opal_mbr)))
> +		return -EFAULT;
> +
> +	if (mbr.enable_disable != OPAL_MBR_ENABLE &&
> +	    mbr.enable_disable != OPAL_MBR_DISABLE)
> +		return -EINVAL;
> +
> +	dev = get_or_create_opal_dev(bdev, mbr.key.lr, true);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	completion = setup_opal_dev(bdev, dev, mbr_funcs, &mbr.key);
> +	if (IS_ERR(completion)) {
> +		ret = PTR_ERR(completion);
> +		goto error_return;
> +	}
> +
> +	dev->num_func_data = 6;
> +	dev->func_data = func_data;
> +	dev->func_data[2] = &mbr.enable_disable;
> +	dev->func_data[5] = &mbr.enable_disable;
> +
> +	next(0, dev);
> +	ret = wait_for_cmd_completion(completion);
> +
> + error_return:
> +	remove_and_clean_opal_dev(dev);
> +	return ret;
> +
> +}
> +EXPORT_SYMBOL(opal_enable_disable_shadow_mbr);
> +
> +int opal_save(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_lock_unlock lkul;
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&lkul, key->opal_lk_unlk, sizeof(*key->opal)))
> +		return -EFAULT;
> +
> +	return opal_save_internal(bdev, &lkul);
> +}
> +EXPORT_SYMBOL(opal_save);
> +
> +int opal_add_user_to_lr(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_lock_unlock lkul;
> +
> +	if (copy_from_user(&lkul, key->opal_lk_unlk, sizeof(lkul)))
> +		return -EFAULT;
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't assign user to LR without backing disk\n");
> +		return -EFAULT;
> +	}
> +	if (lkul.l_state != OPAL_RO && lkul.l_state != OPAL_RW) {
> +		pr_err("Locking state was not RO or RW\n");
> +		return -EINVAL;
> +	}
> +	if (lkul.authority.who < OPAL_USER1 &&
> +	    lkul.authority.who > OPAL_USER9) {
> +		pr_err("Authority was not within the range of users: %d\n",
> +		       lkul.authority.who);
> +		return -EINVAL;
> +	}
> +	if (lkul.authority.SUM) {
> +		pr_err("%s not supported in SUM. Use setup locking range\n",
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	return add_user_lr_internal(bdev, &lkul);
> +}
> +EXPORT_SYMBOL(opal_add_user_to_lr);
> +
> +int opal_reverttper(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_key k;
> +
> +	if (copy_from_user(&k, key->opal, sizeof(*key->opal)))
> +		return -EFAULT;
> +
> +	return opal_revert(bdev, &k);
> +}
> +EXPORT_SYMBOL(opal_reverttper);
> +
> +int opal_lock_unlock(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_lock_unlock k;
> +
> +	if (copy_from_user(&k, key->opal_lk_unlk, sizeof(*key->opal_lk_unlk)))
> +		return -EFAULT;
> +
> +	if (k.authority.who < OPAL_ADMIN1 || k.authority.who >= OPAL_USER9)
Should this be > OPAL_USER9 ?


> +		return -EINVAL;
> +
> +	return lock_unlock_internal(bdev, &k);
> +}
> +EXPORT_SYMBOL(opal_lock_unlock);
> +
> +int opal_take_ownership(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_key k;
> +	const opal_step owner_funcs[] = {
> +		opal_discovery0,
> +		start_anybodyASP_opal_session,
> +		get_msid_cpin_pin,
> +		end_opal_session,
> +		start_SIDASP_opal_session,
> +		set_sid_cpin_pin,
> +		end_opal_session,
> +		NULL
> +	};
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&k, key->opal, sizeof(*key->opal)))
> +		return -EFAULT;
> +
> +	return opal_register(bdev, &k, owner_funcs);
> +}
> +EXPORT_SYMBOL(opal_take_ownership);
> +
> +int opal_activate_lsp(struct block_device *bdev, struct sed_key *key)
> +{
> +	struct opal_key k;
> +	const opal_step active_funcs[] = {
> +		opal_discovery0,
> +		start_SIDASP_opal_session, /* Open session as SID auth */
> +		get_lsp_lifecycle,
> +		activate_lsp,
> +		end_opal_session,
> +		NULL
> +	};
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&k, key->opal, sizeof(*key->opal)))
> +		return -EFAULT;
> +
> +	return opal_act_lsp_int(bdev, &k, active_funcs);
> +}
> +EXPORT_SYMBOL(opal_activate_lsp);
> +
> +int opal_setup_locking_range(struct block_device *bdev, struct sed_key *pw)
> +{
> +	struct opal_user_lr_setup k;
> +
> +	if (!bdev || !bdev->bd_disk) {
> +		pr_err("Can't save password for NULL block device.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&k, pw->opal_lrs, sizeof(*pw->opal_lrs)))
> +		return -EFAULT;
> +
> +	return internal_setup_lr(bdev, &k);
> +}
> +
> +int opal_set_new_pw(struct block_device *bdev, struct sed_key *pw)
> +{
> +	struct opal_new_pw k;
> +
> +	if (pw->sed_type != OPAL_PW)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&k, pw->opal_pw, sizeof(*pw->opal_pw)))
> +		return -EFAULT;
> +
> +	if (k.who.who < OPAL_ADMIN1 || k.who.who > OPAL_USER9)
> +		return -EINVAL;
> +
> +	return opal_set_pw(bdev, &k);
> +}
> +EXPORT_SYMBOL(opal_set_new_pw);
> +
> +int opal_activate_user(struct block_device *bdev, struct sed_key *pw)
> +{
> +	struct opal_activate_user k;
> +
> +	if (pw->sed_type != OPAL_ACT_USR) {
> +		pr_err("Sed type was not act user\n");
> +		return -EINVAL;
> +	}
> +
> +	if (copy_from_user(&k, pw->opal_act, sizeof(*pw->opal_act))) {
> +		pr_err("copy from user error\n");
> +		return -EFAULT;
> +	}
> +
> +	/* We can't activate Admin1 it's active as manufactured */
> +	if (k.who.who < OPAL_USER1 && k.who.who > OPAL_USER9) {
> +		pr_err("Who was not a valid user: %d \n", k.who.who);
> +		return -EINVAL;
> +	}
> +
> +	return activate_user(bdev, &k);
> +
> +}
> +EXPORT_SYMBOL(opal_activate_user);
> +
> +int opal_unlock_from_suspend(struct opal_suspend_unlk *data)
> +{
> +	const char *diskname = data->name;
> +	struct opal_dev *iter, *dev = NULL;
> +	struct opal_completion *completion;
> +	void *func_data[3] = { NULL };
> +	const opal_step _unlock_funcs_SUM[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		lock_unlock_locking_range,
Did you mean to use lock_unlock_locking_range_SUM ?
Can we pull these two arrays out since they are required for both this
function and lock_unlock_internal ?


> +		end_opal_session,
> +		NULL
> +	};
> +	const opal_step _unlock_funcs[] = {
> +		opal_discovery0,
> +		start_auth_opal_session,
> +		lock_unlock_locking_range,
> +		end_opal_session,
> +		NULL
> +	};
> +
> +
> +	spin_lock(&list_spinlock);
> +	list_for_each_entry(iter, &opal_list, node) {
> +		if (strncmp(iter->disk_name, diskname, DISK_NAME_LEN)) {
> +			pr_err("iterdisk was %s and diskname is %s\n",
> +			       iter->disk_name, diskname);
> +			continue;
> +		}
> +		if (atomic_add_unless(&iter->in_use, 1, 1)) {
> +			dev = iter;
> +			dev->func_data = func_data;
> +			dev->resume_from_suspend = true;
> +			dev->resume_data = data;
> +			dev->final_cb = unlock_suspend_final;
> +			dev->final_cb_data = dev;
> +			dev->error_cb = end_opal_session_error;
> +			dev->error_cb_data = dev;
> +			dev->state = 0;
> +			if (dev->lkul.authority.SUM)
> +				dev->funcs = _unlock_funcs_SUM;
> +			else
> +				dev->funcs = _unlock_funcs;
> +			dev->TSN = 0;
> +			dev->HSN = 0;
> +			dev->func_data[2] = &dev->lkul;
> +			dev->func_data[1] = &dev->lkul.authority;
> +			completion = dev->completion;
> +			next(0, dev);
> +			wait_for_cmd_completion(completion);
> +		}
> +	}
> +	spin_unlock(&list_spinlock);
> +
> +	if (!dev)
> +		return -ENODEV;
> +	return 0;
> +}
> +EXPORT_SYMBOL(opal_unlock_from_suspend);
> diff --git a/lib/sed-opal_internal.h b/lib/sed-opal_internal.h
> new file mode 100644
> index 0000000..c9d3883
> --- /dev/null
> +++ b/lib/sed-opal_internal.h
> @@ -0,0 +1,586 @@
> +/*
> + * Copyright ? 2016 Intel Corporation
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Author:
> + *    Rafael Antognolli <rafael.antognolli at intel.com>
> + *    Scott  Bauer      <scott.bauer at intel.com>
> + */
> +
> +#ifndef _NVME_OPAL_INTERNAL_H
> +#define _NVME_OPAL_INTERNAL_H
> +
> +#include <linux/key-type.h>
> +#include <keys/user-type.h>
> +
> +#define DTAERROR_NO_METHOD_STATUS 0x89
> +
> +static const char *opal_errors[19] = {
Remove the 19 so it's just opal_errors[] (doesnt silently truncate any
new additions)


> +	"Success",
> +	"Not Authorized",
> +	"Unknown Error",
> +	"SP Busy",
> +	"SP Failed",
> +	"SP Disabled",
> +	"SP Frozen",
> +	"No Sessions Available",
> +	"Uniqueness Conflict",
> +	"Insufficient Space",
> +	"Insufficient Rows",
> +	"Invalid Function",
> +	"Invalid Parameter",
> +	"Invalid Reference",
> +	"Unknown Error",
> +	"TPER Malfunction",
> +	"Transaction Failure",
> +	"Response Overflow",
> +	"Authority Locked Out",
> +};
> +
> +static const char *opal_error_to_human(int error)
> +{
> +	if (error == 0x3f)
> +		return "Failed";
> +
> +	if (error >= sizeof(opal_errors) || error < 0)
You want sizeof(opal_errors)/sizeof(*opal_errors) here, but you can just
use the ARRAY_SIZE macro instead


> +		return "Unknown Error";
> +
> +	return opal_errors[error];
> +}
> +
> +/* User IDs used in the TCG storage SSCs */
> +static const u8 OPALUID[][8] = {
> +	/* users */
> +
> +	/* session management  */
> +	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff},
> +	/* special "thisSP" syntax */
> +	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 },
> +	/* Administrative SP */
> +	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x01 },
> +	/* Locking SP */
> +	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x02 },
> +	/* ENTERPRISE Locking SP  */
> +	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x01 },
> +	/* anybody */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01 },
> +	/* SID */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x06 },
> +	/* ADMIN1 */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x01 },
> +	/* USER1 */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x01 },
> +	/* USER2 */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x02 },
> +	/* PSID user */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0xff, 0x01 },
> +	/* BandMaster 0 */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x80, 0x01 },
> +	 /* EraseMaster */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
> +
> +	/* tables */
> +
> +	/* Locking_GlobalRange */
> +	{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },
> +	/* ACE_Locking_Range_Set_RdLocked UID */
> +	{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 },
> +	/* ACE_Locking_Range_Set_WrLocked UID */
> +	{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE8, 0x01 },
> +	/* MBR Control */
> +	{ 0x00, 0x00, 0x08, 0x03, 0x00, 0x00, 0x00, 0x01 },
> +	/* Shadow MBR */
> +	{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 },
> +	/* AUTHORITY_TABLE */
> +	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00},
> +	/* C_PIN_TABLE */
> +	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00},
> +	/* OPAL Locking Info */
> +	{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 },
> +	/* Enterprise Locking Info */
> +	{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },
> +
> +	/* C_PIN_TABLE object ID's */
> +
> +	/* C_PIN_MSID */
> +	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
> +	/* C_PIN_SID */
> +	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01},
> +	 /* C_PIN_ADMIN1 */
> +	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},
> +
> +	/* half UID's (only first 4 bytes used) */
> +
> +	/* Half-UID ? Authority_object_ref */
> +	{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
> +	/* Half-UID ? Boolean ACE */
> +	{ 0x00, 0x00, 0x04, 0x0E, 0xff, 0xff, 0xff, 0xff },
> +
> +	/* special value for omitted optional parameter */
> +
> +	/* HEXFF for omitted */
> +	{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
> +};
> +static const size_t OPAL_UID_LENGTH = 8;
> +static const size_t OPAL_MSID_KEYLEN = 15;
> +static const size_t OPAL_UID_LENGTH_HALF = 4;
> +
> +
> +/* Enum to index OPALUID array */
> +enum OPAL_UID {
> +	/* users */
> +	OPAL_SMUID_UID,
> +	OPAL_THISSP_UID,
> +	OPAL_ADMINSP_UID,
> +	OPAL_LOCKINGSP_UID,
> +	OPAL_ENTERPRISE_LOCKINGSP_UID,
> +	OPAL_ANYBODY_UID,
> +	OPAL_SID_UID,
> +	OPAL_ADMIN1_UID,
> +	OPAL_USER1_UID,
> +	OPAL_USER2_UID,
> +	OPAL_PSID_UID,
> +	OPAL_ENTERPRISE_BANDMASTER0_UID,
> +	OPAL_ENTERPRISE_ERASEMASTER_UID,
> +	/* tables */
> +	OPAL_LOCKINGRANGE_GLOBAL,
> +	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
> +	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
> +	OPAL_MBRCONTROL,
> +	OPAL_MBR,
> +	OPAL_AUTHORITY_TABLE,
> +	OPAL_C_PIN_TABLE,
> +	OPAL_LOCKING_INFO_TABLE,
> +	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
> +	/* C_PIN_TABLE object ID's */
> +	OPAL_C_PIN_MSID,
> +	OPAL_C_PIN_SID,
> +	OPAL_C_PIN_ADMIN1,
> +	/* half UID's (only first 4 bytes used) */
> +	OPAL_HALF_UID_AUTHORITY_OBJ_REF,
> +	OPAL_HALF_UID_BOOLEAN_ACE,
> +	/* omitted optional parameter */
> +	OPAL_UID_HEXFF,
> +};
> +
> +/*
> + * TCG Storage SSC Methods.
> + */
> +static const u8 OPALMETHOD[][8] = {
> +	/* Properties */
> +	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 },
> +	/* STARTSESSION */
> +	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x02 },
> +	/* Revert */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x02 },
> +	/* Activate */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x03 },
> +	/* Enterprise Get */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x06 },
> +	/* Enterprise Set */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07 },
> +	/* NEXT */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x08 },
> +	/* Enterprise Authenticate */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0c },
> +	/* GetACL */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0d },
> +	/* GenKey */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x10 },
> +	/* revertSP */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x11 },
> +	/* Get */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x16 },
> +	/* Set */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x17 },
> +	/* Authenticate */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x1c },
> +	/* Random */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x06, 0x01 },
> +	/* Erase */
> +	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 },
> +};
> +static const size_t OPAL_METHOD_LENGTH = 8;
> +
> +/* Enum for indexing the OPALMETHOD array */
> +enum OPAL_METHOD {
> +	OPAL_PROPERTIES,
> +	OPAL_STARTSESSION,
> +	OPAL_REVERT,
> +	OPAL_ACTIVATE,
> +	OPAL_EGET,
> +	OPAL_ESET,
> +	OPAL_NEXT,
> +	OPAL_EAUTHENTICATE,
> +	OPAL_GETACL,
> +	OPAL_GENKEY,
> +	OPAL_REVERTSP,
> +	OPAL_GET,
> +	OPAL_SET,
> +	OPAL_AUTHENTICATE,
> +	OPAL_RANDOM,
> +	OPAL_ERASE,
> +};
> +
> +enum OPAL_RESPONSE_TOKEN {
> +	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
> +	OPAL_DTA_TOKENID_SINT = 0xe1,
> +	OPAL_DTA_TOKENID_UINT = 0xe2,
> +	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
> +	OPAL_DTA_TOKENID_INVALID = 0X0
> +};
> +
> +enum OPAL_TOKEN {
> +	/* Boolean */
> +	OPAL_TRUE = 0x01,
> +	OPAL_FALSE = 0x00,
> +	OPAL_BOOLEAN_EXPR = 0x03,
> +	/* cellblocks */
> +	OPAL_TABLE = 0x00,
> +	OPAL_STARTROW = 0x01,
> +	OPAL_ENDROW = 0x02,
> +	OPAL_STARTCOLUMN = 0x03,
> +	OPAL_ENDCOLUMN = 0x04,
> +	OPAL_VALUES = 0x01,
> +	/* authority table */
> +	OPAL_PIN = 0x03,
> +	/* locking tokens */
> +	OPAL_RANGESTART = 0x03,
> +	OPAL_RANGELENGTH = 0x04,
> +	OPAL_READLOCKENABLED = 0x05,
> +	OPAL_WRITELOCKENABLED = 0x06,
> +	OPAL_READLOCKED = 0x07,
> +	OPAL_WRITELOCKED = 0x08,
> +	OPAL_ACTIVEKEY = 0x0A,
> +	/* locking info table */
> +	OPAL_MAXRANGES = 0x04,
> +	 /* mbr control */
> +	OPAL_MBRENABLE = 0x01,
> +	OPAL_MBRDONE = 0x02,
> +	/* properties */
> +	OPAL_HOSTPROPERTIES = 0x00,
> +	/* atoms */
> +	OPAL_STARTLIST = 0xf0,
> +	OPAL_ENDLIST = 0xf1,
> +	OPAL_STARTNAME = 0xf2,
> +	OPAL_ENDNAME = 0xf3,
> +	OPAL_CALL = 0xf8,
> +	OPAL_ENDOFDATA = 0xf9,
> +	OPAL_ENDOFSESSION = 0xfa,
> +	OPAL_STARTTRANSACTON = 0xfb,
> +	OPAL_ENDTRANSACTON = 0xfC,
> +	OPAL_EMPTYATOM = 0xff,
> +	OPAL_WHERE = 0x00,
> +};
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
> +
> +enum OPAL_ATOM_WIDTH {
> +	OPAL_WIDTH_TINY,
> +	OPAL_WIDTH_SHORT,
> +	OPAL_WIDTH_MEDIUM,
> +	OPAL_WIDTH_LONG,
> +	OPAL_WIDTH_TOKEN
> +};
> +
> +/* Locking state for a locking range */
> +enum OPAL_LOCKINGSTATE {
> +	OPAL_LOCKING_READWRITE = 0x01,
> +	OPAL_LOCKING_READONLY = 0x02,
> +	OPAL_LOCKING_LOCKED = 0x03,
> +};
> +
> +/*
> + * Structures to build and decode the Opal SSC messages
> + * fields that are NOT really numeric are defined as u8[] to
> + * help reduce the endianness issues
> + */
> +
> +/* Comm Packet (header) for transmissions. */
> +struct opal_compacket {
> +	u32 reserved0;
> +	u8 extendedComID[4];
> +	u32 outstandingData;
> +	u32 minTransfer;
> +	u32 length;
> +};
> +
> +/* Packet structure. */
> +struct opal_packet {
> +	u32 TSN;
> +	u32 HSN;
> +	u32 seq_number;
> +	u16 reserved0;
> +	u16 ack_type;
> +	u32 acknowledgment;
> +	u32 length;
> +};
> +
> +/* Data sub packet header */
> +struct opal_data_subpacket {
> +	u8 reserved0[6];
> +	u16 kind;
> +	u32 length;
> +};
> +
> +/* header of a response */
> +struct opal_header {
> +	struct opal_compacket cp;
> +	struct opal_packet pkt;
> +	struct opal_data_subpacket subpkt;
> +};
> +
> +#define FC_TPER       0x0001
> +#define FC_LOCKING    0x0002
> +#define FC_GEOMETRY   0x0003
> +#define FC_ENTERPRISE 0x0100
> +#define FC_DATASTORE  0x0202
> +#define FC_SINGLEUSER 0x0201
> +#define FC_OPALV100   0x0200
> +#define FC_OPALV200   0x0203
> +
> +/*
> + * The Discovery 0 Header. As defined in
> + * Opal SSC Documentation
> + */
> +struct d0_header {
> +	u32 length; /* the length of the header 48 in 2.00.100 */
> +	u32 revision; /**< revision of the header 1 in 2.00.100 */
> +	u32 reserved01;
> +	u32 reserved02;
> +	/*
> +	 * the remainder of the structure is vendor specific and will not be
> +	 * addressed now
> +	 */
> +	u8 ignored[32];
> +};
> +
> +/*
> + * TPer Feature Descriptor. Contains flags indicating support for the
> + * TPer features described in the OPAL specification. The names match the
> + * OPAL terminology
> + *
> + * code == 0x001 in 2.00.100
> + */
> +struct d0_tper_features {
> +	/*
> +	 * supported_features bits:
> +	 * bit 7: reserved
> +	 * bit 6: com ID management
> +	 * bit 5: reserved
> +	 * bit 4: streaming support
> +	 * bit 3: buffer management
> +	 * bit 2: ACK/NACK
> +	 * bit 1: async
> +	 * bit 0: sync
> +	 */
> +	u8 supported_features;
> +	/*
> +	 * bytes 5 through 15 are reserved, but we represent the first 3 as
> +	 * u8 to keep the other two 32bits integers aligned.
> +	 */
> +	u8 reserved01[3];
> +	u32 reserved02;
> +	u32 reserved03;
> +};
> +
> +/*
> + * Locking Feature Descriptor. Contains flags indicating support for the
> + * locking features described in the OPAL specification. The names match the
> + * OPAL terminology
> + *
> + * code == 0x0002 in 2.00.100
> + */
> +struct d0_locking_features {
> +	/*
> +	 * supported_features bits:
> +	 * bits 6-7: reserved
> +	 * bit 5: MBR done
> +	 * bit 4: MBR enabled
> +	 * bit 3: media encryption
> +	 * bit 2: locked
> +	 * bit 1: locking enabled
> +	 * bit 0: locking supported
> +	 */
> +	u8 supported_features;
> +	/*
> +	 * bytes 5 through 15 are reserved, but we represent the first 3 as
> +	 * u8 to keep the other two 32bits integers aligned.
> +	 */
> +	u8 reserved01[3];
> +	u32 reserved02;
> +	u32 reserved03;
> +};
> +
> +/*
> + * Geometry Feature Descriptor. Contains flags indicating support for the
> + * geometry features described in the OPAL specification. The names match the
> + * OPAL terminology
> + *
> + * code == 0x0003 in 2.00.100
> + */
> +struct d0_geometry_features {
> +	/*
> +	 * skip 32 bits from header, needed to align the struct to 64 bits.
> +	 */
> +	u8 header[4];
> +	/*
> +	 * reserved01:
> +	 * bits 1-6: reserved
> +	 * bit 0: align
> +	 */
> +	u8 reserved01;
> +	u8 reserved02[7];
> +	u32 logical_block_size;
> +	u64 alignment_granularity;
> +	u64 lowest_aligned_lba;
> +};
> +
> +/*
> + * Enterprise SSC Feature
> + *
> + * code == 0x0100
> + */
> +struct d0_enterprise_ssc {
> +	u16 baseComID;
> +	u16 numComIDs;
> +	/* range_crossing:
> +	 * bits 1-6: reserved
> +	 * bit 0: range crossing
> +	 */
> +	u8 range_crossing;
> +	u8 reserved01;
> +	u16 reserved02;
> +	u32 reserved03;
> +	u32 reserved04;
> +};
> +
> +/*
> + * Opal V1 feature
> + *
> + * code == 0x0200
> + */
> +struct d0_opal_v100 {
> +	u16 baseComID;
> +	u16 numComIDs;
> +};
> +
> +/*
> + * Single User Mode feature
> + *
> + * code == 0x0201
> + */
> +struct d0_single_user_mode {
> +	u32 num_locking_objects;
> +	/* reserved01:
> +	 * bit 0: any
> +	 * bit 1: all
> +	 * bit 2: policy
> +	 * bits 3-7: reserved
> +	 */
> +	u8 reserved01;
> +	u8 reserved02;
> +	u16 reserved03;
> +	u32 reserved04;
> +};
> +
> +/*
> + * Additonal Datastores feature
> + *
> + * code == 0x0202
> + */
> +struct d0_datastore_table {
> +	u16 reserved01;
> +	u16 max_tables;
> +	u32 max_size_tables;
> +	u32 table_size_alignment;
> +};
> +
> +/*
> + * OPAL 2.0 feature
> + *
> + * code == 0x0203
> + */
> +struct d0_opal_v200 {
> +	u16 baseComID;
> +	u16 numComIDs;
> +	/* range_crossing:
> +	 * bits 1-6: reserved
> +	 * bit 0: range crossing
> +	 */
> +	u8 range_crossing;
> +	/* num_locking_admin_auth:
> +	 * not aligned to 16 bits, so use two u8.
> +	 * stored in big endian:
> +	 * 0: MSB
> +	 * 1: LSB
> +	 */
> +	u8 num_locking_admin_auth[2];
> +	/* num_locking_user_auth:
> +	 * not aligned to 16 bits, so use two u8.
> +	 * stored in big endian:
> +	 * 0: MSB
> +	 * 1: LSB
> +	 */
> +	u8 num_locking_user_auth[2];
> +	u8 initialPIN;
> +	u8 revertedPIN;
> +	u8 reserved01;
> +	u32 reserved02;
> +};
> +
> +/* Union of features used to parse the discovery 0 response */
> +struct d0_features {
> +	u16 code;
> +	/*
> +	 * r_version bits:
> +	 * bits 4-7: version
> +	 * bits 0-3: reserved
> +	 */
> +	u8 r_version;
> +	u8 length;
> +	u8 features[];
> +};
> +
> +struct key *request_user_key(const char *master_desc, const u8 **master_key,
> +			     size_t *master_keylen);
> +
> +#endif /* _NVME_OPAL_INTERNAL_H */
> diff --git a/lib/sed-opal_key.c b/lib/sed-opal_key.c
> new file mode 100644
> index 0000000..0b4de01
> --- /dev/null
> +++ b/lib/sed-opal_key.c
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright ? 2016 Intel Corporation
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice (including the next
> + * paragraph) shall be included in all copies or substantial portions of the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
> + * IN THE SOFTWARE.
> + *
> + * Author:
> + *    Rafael Antognolli <rafael.antognolli at intel.com>
> + */
> +
> +#include <linux/key.h>
> +#include "sed-opal_internal.h"
> +
> +struct key *request_user_key(const char *master_desc, const u8 **master_key,
> +			     size_t *master_keylen)
> +{
> +	const struct user_key_payload *upayload;
> +	struct key *ukey;
> +
> +	ukey = request_key(&key_type_user, master_desc, NULL);
> +	if (IS_ERR(ukey))
> +		goto error;
> +
> +	down_read(&ukey->sem);
> +	upayload = user_key_payload(ukey);
> +	*master_key = upayload->data;
> +	*master_keylen = upayload->datalen;
> +error:
> +	return ukey;
> +}
> diff --git a/lib/sed.c b/lib/sed.c
> new file mode 100644
> index 0000000..06cacd9
> --- /dev/null
> +++ b/lib/sed.c
> @@ -0,0 +1,303 @@
> +#include <linux/blkdev.h>
> +#include <linux/sed.h>
> +#include <linux/sed-opal.h>
> +
> +#ifndef CONFIG_SED_OPAL
> +static int sed_opal_save(struct block_device *bdev, struct sed_key *sed)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_lock_unlock(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_take_ownership(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_activate_lsp(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_set_pw(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_activate_user(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_reverttper(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_setup_locking_range(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_adduser_to_lr(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_do_mbr(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +static int sed_opal_erase_lr(struct block_device *bdev, struct sed_key *key)
> +	{ return -EOPNOTSUPP; }
> +
> +#else
> +
> +static int sed_opal_save(struct block_device *bdev, struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
You might consider pulling this boilerplate out into something like:
static inline bool bdev_sec_capable(struct block_device *bdev)
{
	return bdev && bdev->bd_disk && bdev->bd_disk->fops &&
	       bdev->bd_disk->fops->sec_ops;
}


> +
> +	return opal_save(bdev, key);
> +}
> +
> +static int sed_opal_lock_unlock(struct block_device *bdev, struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_lock_unlock(bdev, key);
> +}
> +
> +static int sed_opal_take_ownership(struct block_device *bdev,
> +				   struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_take_ownership(bdev, key);
> +}
> +
> +static int sed_opal_activate_lsp(struct block_device *bdev,
> +				 struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_activate_lsp(bdev, key);
> +}
> +
> +static int sed_opal_set_pw(struct block_device *bdev,
> +			   struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_set_new_pw(bdev, key);
> +}
> +
> +static int sed_opal_activate_user(struct block_device *bdev,
> +				  struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_activate_user(bdev, key);
> +}
> +
> +static int sed_opal_reverttper(struct block_device *bdev,
> +			       struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_reverttper(bdev, key);
> +}
> +
> +static int sed_opal_setup_lr(struct block_device *bdev,
> +			     struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_setup_locking_range(bdev, key);
> +}
> +
> +static int sed_opal_adduser_to_lr(struct block_device *bdev,
> +			     struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_add_user_to_lr(bdev, key);
> +}
> +
> +static int sed_opal_do_mbr(struct block_device *bdev,
> +			   struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_enable_disable_shadow_mbr(bdev, key);
> +}
> +
> +static int sed_opal_erase_lr(struct block_device *bdev,
> +			     struct sed_key *key)
> +{
> +
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	return opal_erase_locking_range(bdev, key);
> +}
> +#endif
> +
> +int sed_save(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_LOCK_UNLOCK:
> +		return sed_opal_save(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_lock_unlock(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_LOCK_UNLOCK:
> +		return sed_opal_lock_unlock(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_take_ownership(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL:
> +		return sed_opal_take_ownership(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_activate_lsp(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL:
> +		return sed_opal_activate_lsp(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_set_pw(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_PW:
> +		return sed_opal_set_pw(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_activate_user(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_ACT_USR:
> +		return sed_opal_activate_user(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_reverttper(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL:
> +		return sed_opal_reverttper(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_setup_locking_range(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_LR_SETUP:
> +		return sed_opal_setup_lr(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_adduser_to_lr(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_LOCK_UNLOCK:
> +		return sed_opal_adduser_to_lr(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_do_mbr(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL_MBR_DATA:
> +		return sed_opal_do_mbr(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +int sed_erase_lr(struct block_device *bdev, struct sed_key *key)
> +{
> +	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->fops ||
> +	    !bdev->bd_disk->fops->sec_ops)
> +		return -EOPNOTSUPP;
> +
> +	switch (key->sed_type) {
> +	case OPAL:
> +		return sed_opal_erase_lr(bdev, key);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> -- 
> 2.7.4
> 
