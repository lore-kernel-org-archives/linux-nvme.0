From: rafael.antognolli@intel.com (Rafael Antognolli)
Date: Fri, 22 Apr 2016 16:12:11 -0700
Subject: [PATCH 1/2] Add optane OPAL unlocking code.
In-Reply-To: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
References: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>
Message-ID: <1461366732-31779-2-git-send-email-rafael.antognolli@intel.com>

This code is used to unlock a device during resume from "suspend to RAM". It
allows the userspace to set a key for a locking range. This key is stored in
the module memory, and will be replayed later (using the OPAL protocol, through
the NVMe driver) to unlock the locking range.

The nvme_opal_unlock() will search through the list of saved devices +
locking_range + namespaces + keys and check if it is a match for this
namespace. For every match, it adds an "unlocking job" to a list, and after
this, these jobs are "consumed" by running the respective OPAL "unlock range"
commands (from the OPAL spec):
  * STARTSESSION
  * SET(locking range, readwrite)
  * ENDSESSION

Signed-off-by: Rafael Antognolli <rafael.antognolli at intel.com>
---
 drivers/nvme/host/Kconfig         |    7 +
 drivers/nvme/host/Makefile        |    1 +
 drivers/nvme/host/opal.c          | 1270 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/opal.h          |   73 +++
 drivers/nvme/host/opal_internal.h |  501 +++++++++++++++
 5 files changed, 1852 insertions(+)
 create mode 100644 drivers/nvme/host/opal.c
 create mode 100644 drivers/nvme/host/opal.h
 create mode 100644 drivers/nvme/host/opal_internal.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index c894841..f326c40 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -24,3 +24,10 @@ config BLK_DEV_NVME_SCSI
 	  to say N here, unless you run a distro that abuses the SCSI
 	  emulation to provide stable device names for mount by id, like
 	  some OpenSuSE and SLES versions.
+
+config BLK_DEV_NVME_OPAL
+	bool "Opal encryption resume support"
+	depends on BLK_DEV_NVME
+	---help---
+	  Self encrypting devices that support the Opal specification need this
+	  option enabled to support resume from S3 and S0ix states.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 9a3ca89..fdaa3cb 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 nvme-core-y				:= core.o
 nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
+nvme-core-$(CONFIG_BLK_DEV_NVME_OPAL)	+= opal.o
 
 nvme-y					+= pci.o
diff --git a/drivers/nvme/host/opal.c b/drivers/nvme/host/opal.c
new file mode 100644
index 0000000..6f14636
--- /dev/null
+++ b/drivers/nvme/host/opal.c
@@ -0,0 +1,1270 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "opal.h"
+#include "opal_internal.h"
+#include "nvme.h"
+
+#define KEY_MAX 256
+
+/* From include/linux/nvme.h. */
+#define SERIAL_MAX 20
+#define MODEL_MAX 40
+#define IO_BUFFER_LENGTH 2048
+
+#define MAX_TOKS 64
+
+struct nvme_opal_dev {
+	uint8_t serial[SERIAL_MAX];
+	uint8_t model[MODEL_MAX];
+	uint8_t key[KEY_MAX];
+	unsigned nsid;
+	uint8_t locking_range;
+	uint16_t comID;
+	struct list_head node;
+	struct kref refcount;
+};
+
+struct opal_job {
+	struct nvme_ns *ns;
+	struct nvme_opal_dev *dev;
+	struct list_head node;
+};
+
+struct opal_cmd {
+	uint32_t pos;
+	uint8_t cmd[IO_BUFFER_LENGTH];
+	uint8_t resp[IO_BUFFER_LENGTH];
+};
+
+/*
+ * On the parsed response, we don't store again the toks that are already
+ * stored in the response buffer. Instead, for each token, we just store a
+ * pointer to the position in the buffer where the token starts, and the size
+ * of the token in bytes.
+ */
+struct opal_resp_tok {
+	const uint8_t *pos;
+	size_t len;
+	enum OPAL_RESPONSE_TOKEN type;
+	enum OPAL_ATOM_WIDTH width;
+	union {
+		uint64_t u;
+		int64_t s;
+	} stored;
+};
+
+/*
+ * From the response header it's not possible to know how many tokens there are
+ * on the payload. So we hardcode that the maximum will be MAX_TOKS, and later
+ * if we start dealing with messages that have more than that, we can increase
+ * this number. This is done to avoid having to make two passes through the
+ * response, the first one counting how many tokens we have and the second one
+ * actually storing the positions.
+ */
+struct parsed_resp {
+	int num;
+	uint8_t buf[IO_BUFFER_LENGTH];
+	struct opal_resp_tok toks[MAX_TOKS];
+};
+
+static LIST_HEAD(opal_list);
+static DEFINE_MUTEX(opal_list_mutex);
+
+static struct opal_cmd *alloc_opal_cmd(void)
+{
+	struct opal_cmd *cmd;
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd)
+		return ERR_PTR(-ENOMEM);
+
+	cmd->pos = sizeof(struct opal_header);
+	return cmd;
+}
+
+static int _nvme_opal_submit_cmd(struct nvme_ns *ns, uint8_t opcode,
+				 uint16_t comID, void *buffer,
+				 size_t buflen)
+{
+	struct nvme_command c;
+	uint32_t protocol = 0x01;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = opcode;
+	c.common.nsid = ns->ns_id;
+	c.common.cdw10[0] = protocol << 24 | comID << 8;
+	c.common.cdw10[1] = buflen;
+
+	return nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, buffer, buflen);
+}
+
+static void print_buffer(const uint8_t *ptr, uint32_t length)
+{
+#ifdef DEBUG
+	uint32_t i;
+
+	printk("OPAL: Printing buffer:\n");
+	for (i = 0; i < length; i++) {
+		printk("%02x", ptr[i]);
+		if ((i + 1) % 16 == 0)
+			printk("\n");
+		else if ((i + 1) % 4 == 0)
+			printk(" ");
+	}
+	printk("\n");
+#endif
+}
+
+static bool check_tper(const void *data)
+{
+	const struct d0_tper_features *tper = data;
+	uint8_t flags = tper->supported_features;
+
+	if (!(flags & 0x1)) {
+		pr_err("OPAL: TPer sync not supported. flags = %d\n",
+		       tper->supported_features);
+		return false;
+	}
+
+	return true;
+}
+
+static bool check_locking(const void *data)
+{
+	const struct d0_locking_features *locking = data;
+	uint8_t flags = locking->supported_features;
+
+	pr_debug("OPAL: locking features:\n");
+	pr_debug("OPAL: supported: %d, enabled: %d, locked: %d\n",
+		 flags & 0x1, (flags >> 1) & 0x1, (flags >> 2) & 0x1);
+	pr_debug("OPAL: media encryption: %d, MBR enabled: %d, MBR done: %d\n",
+		 (flags >> 3) & 0x1, (flags >> 4) & 0x1, (flags >> 5) & 0x1);
+
+	return true;
+}
+
+static bool check_SUM(const void *data)
+{
+	const struct d0_single_user_mode *sum = data;
+	uint32_t nlo = be32_to_cpu(sum->num_locking_objects);
+
+	if (nlo == 0) {
+		pr_err("OPAL: need at least one locking object.\n");
+		return false;
+	}
+
+	pr_debug("OPAL: number of locking objects: %d\n", nlo);
+
+	return true;
+}
+
+static uint16_t get_comID_v100(const void *data)
+{
+	const struct d0_opal_v100 *v100 = data;
+	return be16_to_cpu(v100->baseComID);
+}
+
+static uint16_t get_comID_v200(const void *data)
+{
+	const struct d0_opal_v200 *v200 = data;
+	return be16_to_cpu(v200->baseComID);
+}
+
+static int __nvme_opal_discovery0(struct nvme_ns *ns,
+				  uint16_t *comid,
+				  uint8_t *d0_response)
+{
+	uint8_t lastRC;
+	const uint8_t *epos, *cpos;
+	const struct d0_header *hdr;
+	uint16_t comID = 0;
+	bool foundComID = false, supported = true, single_user = false;
+
+	if ((lastRC = _nvme_opal_submit_cmd(
+				ns, nvme_admin_security_recv, 0x0001,
+				d0_response, IO_BUFFER_LENGTH)) != 0) {
+		dev_err(ns->ctrl->dev, "OPAL: Sending discovery0 failed\n");
+		return -EFAULT;
+	}
+
+	epos = d0_response;
+	cpos = d0_response;
+	hdr = (struct d0_header *)d0_response;
+
+	print_buffer(d0_response, be32_to_cpu(hdr->length));
+
+	epos = epos + be32_to_cpu(hdr->length); /* end of buffer */
+	cpos = cpos + 48; /* current position on buffer */
+
+	while (cpos < epos && supported) {
+
+		const struct d0_features *body =
+			(const struct d0_features *)cpos;
+		switch (be16_to_cpu(body->code)) {
+		case FC_TPER:
+			supported = check_tper(body->features);
+			break;
+		case FC_LOCKING:
+			supported = check_locking(body->features);
+			break;
+		case FC_SINGLEUSER:
+			single_user = check_SUM(body->features);
+			break;
+		case FC_GEOMETRY:
+		case FC_ENTERPRISE:
+		case FC_DATASTORE:
+			/* We are only interested on the comID for now.
+			 * Later when we need to check for more
+			 * features, the check should be added here.
+			 */
+			dev_dbg(ns->ctrl->dev,
+				"Found OPAL feature description: %d\n",
+				be16_to_cpu(body->code));
+			break;
+		case FC_OPALV100:
+			comID = get_comID_v100(body->features);
+			foundComID = true;
+			dev_info(ns->ctrl->dev, "Found OPAL v1\n");
+			break;
+		case FC_OPALV200:
+			comID = get_comID_v200(body->features);
+			foundComID = true;
+			dev_info(ns->ctrl->dev, "Found OPAL v2\n");
+			break;
+		default:
+			if (0xbfff <
+			    be16_to_cpu(body->code)) {
+				/* vendor specific, just ignore */
+			} else {
+				dev_warn(ns->ctrl->dev,
+					 "OPAL Unknown feature: %d\n",
+					 be16_to_cpu(body->code));
+			}
+		}
+		cpos = cpos + (body->length + 4);
+	}
+
+	if (!supported) {
+		dev_err(ns->ctrl->dev,
+			"Device not supported\n");
+		return -EINVAL;
+	}
+
+	if (!single_user) {
+		dev_err(ns->ctrl->dev,
+			"Device doesn't support single user mode\n");
+		return -EINVAL;
+	}
+
+	if (!foundComID) {
+		dev_err(ns->ctrl->dev,
+			"Could not find OPAL comID for device\n");
+		dev_err(ns->ctrl->dev,
+			"OPAL kernel unlocking will be disabled\n");
+		return -EPERM;
+	}
+
+	*comid = comID;
+	return 0;
+}
+
+static int nvme_opal_discovery0(struct nvme_ns *ns,
+				uint16_t *comid)
+{
+	int ret;
+	uint8_t *d0_response = NULL;
+
+	d0_response = kzalloc(IO_BUFFER_LENGTH, GFP_KERNEL);
+	if (!d0_response)
+		return -ENOMEM;
+
+	ret = __nvme_opal_discovery0(ns, comid, d0_response);
+
+	kfree(d0_response);
+	return ret;
+}
+
+static int nvme_opal_send_cmd(struct nvme_ns *ns,
+			      uint16_t comID, void *buf,
+			      size_t buflen,
+			      void *resp, size_t resplen)
+{
+	int ret;
+	struct opal_header *hdr = resp;
+	ret = _nvme_opal_submit_cmd(ns, nvme_admin_security_send, comID, buf,
+				    buflen);
+
+	if (ret)
+		return ret;
+
+	do {
+		msleep(25);
+		memset(resp, 0, resplen);
+		ret = _nvme_opal_submit_cmd(ns,
+					    nvme_admin_security_recv,
+					    comID, resp, resplen);
+	} while ((ret == 0) && (hdr->cp.outstandingData != 0) &&
+		 (hdr->cp.minTransfer == 0));
+
+	dev_dbg(ns->ctrl->dev,
+		"Sent OPAL command: ret=%d, outstanding=%d, minTransfer=%d\n",
+		ret, hdr->cp.outstandingData, hdr->cp.minTransfer);
+
+	return ret;
+}
+
+static ssize_t add_token_u8(struct opal_cmd *cmd, uint8_t tok)
+{
+	if (cmd->pos + sizeof(tok) >= IO_BUFFER_LENGTH)
+		return -EFAULT;
+	cmd->cmd[cmd->pos++] = tok;
+	return sizeof(tok);
+}
+
+#define ON_TOKEN_ERROR_RETURN(type, cmd, tok, ret)			\
+	if (add_token_##type(cmd, tok) < 0) {				\
+		pr_err("OPAL: [%s:%d] error building command buffer\n",	\
+		       __func__, __LINE__);				\
+		return ret;						\
+	}
+
+#define ON_TOKEN_ERROR_GOTO(type, cmd, tok, tag)			\
+	if (add_token_##type(cmd, tok) < 0) {				\
+		pr_err("OPAL: [%s:%d] error building command buffer\n",	\
+		       __func__, __LINE__);				\
+		goto tag;						\
+	}
+
+static uint8_t create_short_atom(int bytestring, int has_sign, int len)
+{
+	uint8_t atom;
+
+	atom = (1 << 7) | (bytestring << 5) | (has_sign << 4) | (len & 0xf);
+
+	return atom;
+}
+
+static ssize_t add_token_u64(struct opal_cmd *cmd, uint64_t number)
+{
+	int len;
+	uint8_t atom;
+
+	if (number < 64)
+		return add_token_u8(cmd, number);
+	else {
+		int i, startat;
+
+		if (number < 0x100)
+			len = 1;
+		else if (number < 0x10000)
+			len = 2;
+		else if (number < 0x100000000)
+			len = 4;
+		else
+			len = 8;
+
+		startat = len - 1;
+		atom = create_short_atom(0, 0, len);
+		ON_TOKEN_ERROR_RETURN(u8, cmd, atom, -EFAULT);
+
+		for (i = startat; i > -1; i--) {
+			uint8_t n = (number >> (i * 8)) & 0xff;
+			ON_TOKEN_ERROR_RETURN(u8, cmd, n, -EFAULT);
+		}
+	}
+
+	return len + 1;
+}
+
+static ssize_t add_token_uid(struct opal_cmd *cmd, enum OPAL_UID uid)
+{
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_SHORT_BYTESTRING8, -EFAULT);
+
+	if (cmd->pos + 8 > IO_BUFFER_LENGTH)
+		return -EFAULT;
+	memcpy(&cmd->cmd[cmd->pos], &OPALUID[uid][0], 8);
+	cmd->pos += 8;
+
+	return 8;
+}
+
+static ssize_t add_token_method(struct opal_cmd *cmd, enum OPAL_METHOD method)
+{
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_SHORT_BYTESTRING8, -EFAULT);
+
+	if (cmd->pos + 8 > IO_BUFFER_LENGTH)
+		return -EFAULT;
+	memcpy(&cmd->cmd[cmd->pos], &OPALMETHOD[method][0], 8);
+	cmd->pos += 8;
+
+	return 8;
+}
+
+static ssize_t add_token_range(struct opal_cmd *cmd, uint8_t lr)
+{
+	uint8_t *pos;
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_SHORT_BYTESTRING8, -EFAULT);
+
+	if (cmd->pos + 8 > IO_BUFFER_LENGTH)
+		return -EFAULT;
+
+	pos = &cmd->cmd[cmd->pos];
+	memcpy(pos, &OPALUID[OPAL_LOCKINGRANGE_GLOBAL][0], 8);
+	if (lr == 0) {
+		cmd->pos += 8;
+		return 8;
+	}
+
+	pos[5] = 0x03;
+	cmd->pos += 7;
+	ON_TOKEN_ERROR_RETURN(u8, cmd, lr, -EFAULT);
+
+	return 8;
+}
+
+static ssize_t add_token_array(struct opal_cmd *cmd, const uint8_t *array,
+			       size_t length)
+{
+	if (cmd->pos + length > IO_BUFFER_LENGTH)
+		return -EFAULT;
+	memcpy(&cmd->cmd[cmd->pos], &array[0], length);
+	cmd->pos += length;
+
+	return length;
+}
+
+static ssize_t add_token_bytestring(struct opal_cmd *cmd, const uint8_t *array,
+				    size_t max_length)
+{
+	size_t length = strlen(array);
+
+	if (length > max_length)
+		length = max_length;
+
+	if (cmd->pos + length > IO_BUFFER_LENGTH)
+		return -EFAULT;
+
+	cmd->cmd[cmd->pos++] = 0xd0 | (uint8_t) ((length >> 8) & 0x07);
+	cmd->cmd[cmd->pos++] = (uint8_t) (length & 0xff);
+
+	memcpy(&cmd->cmd[cmd->pos], &array[0], length);
+	cmd->pos += length;
+
+	return length;
+}
+
+static void setComID(struct opal_cmd *cmd, uint16_t comID)
+{
+	struct opal_header *hdr = (struct opal_header *)&cmd->cmd[0];
+	hdr->cp.extendedComID[0] = ((comID & 0xff00) >> 8);
+	hdr->cp.extendedComID[1] = comID & 0x00ff;
+	hdr->cp.extendedComID[2] = 0;
+	hdr->cp.extendedComID[3] = 0;
+}
+
+static int cmd_finalize(struct opal_cmd *cmd, uint32_t hsn, uint32_t tsn)
+{
+	struct opal_header *hdr;
+
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_ENDOFDATA, -EFAULT);
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_STARTLIST, -EFAULT);
+	ON_TOKEN_ERROR_RETURN(u8, cmd, 0, -EFAULT);
+	ON_TOKEN_ERROR_RETURN(u8, cmd, 0, -EFAULT);
+	ON_TOKEN_ERROR_RETURN(u8, cmd, 0, -EFAULT);
+	ON_TOKEN_ERROR_RETURN(u8, cmd, OPAL_ENDLIST, -EFAULT);
+
+	hdr = (struct opal_header *) cmd->cmd;
+
+	hdr->pkt.TSN = cpu_to_be32(tsn);
+	hdr->pkt.HSN = cpu_to_be32(hsn);
+
+	hdr->subpkt.length = cpu_to_be32(cmd->pos - sizeof(*hdr));
+	while (cmd->pos % 4 != 0)
+		cmd->cmd[cmd->pos++] = 0;
+	hdr->pkt.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp) -
+				      sizeof(hdr->pkt));
+	hdr->cp.length = cpu_to_be32(cmd->pos - sizeof(hdr->cp));
+	if (cmd->pos > IO_BUFFER_LENGTH) {
+		pr_err("OPAL: buffer overrun\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static enum OPAL_RESPONSE_TOKEN token_type(const struct parsed_resp *resp,
+					   int n)
+{
+	const struct opal_resp_tok *tok;
+
+	if (n >= resp->num) {
+		pr_err("OPAL: token number doesn't exist: %d, resp: %d\n",
+		       n, resp->num);
+		return OPAL_DTA_TOKENID_INVALID;
+	}
+
+	tok = &resp->toks[n];
+	if (tok->len == 0) {
+		pr_err("OPAL: token length must be non-zero\n");
+		return OPAL_DTA_TOKENID_INVALID;
+	}
+
+	return tok->type;
+}
+
+/*
+ * This function returns 0 in case of invalid token. One should call
+ * token_type() first to find out if the token is valid or not.
+ */
+static enum OPAL_TOKEN response_get_token(const struct parsed_resp *resp,
+					  int n)
+{
+	const struct opal_resp_tok *tok;
+
+	if (n >= resp->num) {
+		pr_err("OPAL: token number doesn't exist: %d, resp: %d\n",
+		       n, resp->num);
+		return 0;
+	}
+
+	tok = &resp->toks[n];
+	if (tok->len == 0) {
+		pr_err("OPAL: token length must be non-zero\n");
+		return 0;
+	}
+
+	return tok->pos[0];
+}
+
+static size_t response_parse_tiny(struct opal_resp_tok *tok,
+				  const uint8_t *pos)
+{
+	tok->pos = pos;
+	tok->len = 1;
+	tok->width = OPAL_WIDTH_TINY;
+
+	if (pos[0] & 0x40) {
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	} else {
+		tok->type = OPAL_DTA_TOKENID_UINT;
+		tok->stored.u = pos[0] & 0x3f;
+	}
+
+	return tok->len;
+}
+
+static size_t response_parse_short(struct opal_resp_tok *tok,
+				   const uint8_t *pos)
+{
+	tok->pos = pos;
+	tok->len = (pos[0] & 0x0f) + 1;
+	tok->width = OPAL_WIDTH_SHORT;
+
+	if (pos[0] & 0x20) {
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	} else if (pos[0] & 0x10) {
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	} else {
+		uint64_t whatever = 0;
+		int i, b = 0;
+		tok->type = OPAL_DTA_TOKENID_UINT;
+		if (tok->len > 9)
+			pr_warn("OPAL: uint64 with more than 8 bytes\n");
+		for (i = tok->len - 1; i > 0; i--) {
+			whatever |= (uint64_t)(pos[i] << (8 * b));
+			b++;
+		}
+		tok->stored.u = whatever;
+	}
+
+	return tok->len;
+}
+
+static size_t response_parse_medium(struct opal_resp_tok *tok,
+				    const uint8_t *pos)
+{
+	tok->pos = pos;
+	tok->len = (((pos[0] & 0x07) << 8) | pos[1]) + 2;
+	tok->width = OPAL_WIDTH_MEDIUM;
+
+	if (pos[0] & 0x10)
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	else if (pos[0] & 0x08)
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	else
+		tok->type = OPAL_DTA_TOKENID_UINT;
+
+	return tok->len;
+}
+
+static size_t response_parse_long(struct opal_resp_tok *tok,
+				  const uint8_t *pos)
+{
+	tok->pos = pos;
+	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
+	tok->width = OPAL_WIDTH_LONG;
+
+	if (pos[0] & 0x02)
+		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
+	else if (pos[0] & 0x01)
+		tok->type = OPAL_DTA_TOKENID_SINT;
+	else
+		tok->type = OPAL_DTA_TOKENID_UINT;
+
+	return tok->len;
+}
+
+static size_t response_parse_token(struct opal_resp_tok *tok,
+				   const uint8_t *pos)
+{
+	tok->pos = pos;
+	tok->len = 1;
+	tok->type = OPAL_DTA_TOKENID_TOKEN;
+	tok->width = OPAL_WIDTH_TOKEN;
+
+	return tok->len;
+}
+
+static struct parsed_resp *response_parse(const void *buf, size_t length)
+{
+	const struct opal_header *hdr;
+	const uint8_t *pos;
+	int e, num_entries = 0;
+	uint32_t cpos = 0, total;
+	struct opal_resp_tok *iter;
+	struct parsed_resp *resp;
+	size_t token_length;
+
+	if (!buf)
+		return ERR_PTR(-EFAULT);
+
+	resp = kzalloc(sizeof(*resp), GFP_KERNEL);
+	if (!resp)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(resp->buf, buf, IO_BUFFER_LENGTH);
+
+	hdr = (struct opal_header *)resp->buf;
+	pos = resp->buf;
+	pos += sizeof(*hdr);
+
+	pr_debug("OPAL: response size: cp: %d, pkt: %d, subpkt: %d\n",
+		 be32_to_cpu(hdr->cp.length),
+		 be32_to_cpu(hdr->pkt.length),
+		 be32_to_cpu(hdr->subpkt.length));
+
+	if ((hdr->cp.length == 0)
+	    || (hdr->pkt.length == 0)
+	    || (hdr->subpkt.length == 0)) {
+		pr_err("OPAL: bad header length. cp: %d, pkt: %d, subpkt: %d\n",
+		       hdr->cp.length, hdr->pkt.length, hdr->subpkt.length);
+		e = -EINVAL;
+		goto err;
+	}
+
+	if (pos > resp->buf + length) {
+		e = -EFAULT;
+		goto err;
+	}
+
+	iter = resp->toks;
+	total = be32_to_cpu(hdr->subpkt.length);
+	print_buffer(pos, total);
+	while (cpos < total) {
+		if (!(pos[0] & 0x80)) /* tiny atom */
+			token_length = response_parse_tiny(iter, pos);
+		else if (!(pos[0] & 0x40)) /* short atom */
+			token_length = response_parse_short(iter, pos);
+		else if (!(pos[0] & 0x20)) /* medium atom */
+			token_length = response_parse_medium(iter, pos);
+		else if (!(pos[0] & 0x10)) /* long atom */
+			token_length = response_parse_long(iter, pos);
+		else /* TOKEN */
+			token_length = response_parse_token(iter, pos);
+
+		pos += token_length;
+		cpos += token_length;
+		iter++;
+		num_entries++;
+	}
+
+	if (num_entries == 0) {
+		pr_err("OPAL: couldn't parse response.\n");
+		e = -EINVAL;
+		goto err;
+	}
+	resp->num = num_entries;
+
+	return resp;
+err:
+	kfree(resp);
+	return ERR_PTR(e);
+}
+
+static uint64_t response_get_u64(const struct parsed_resp *resp, int n)
+{
+	if (!resp) {
+		pr_err("OPAL: response is NULL\n");
+		return 0;
+	}
+
+	if (n > resp->num) {
+		pr_err("OPAL: response has %d tokens. Can't access %d\n",
+		       resp->num, n);
+		return 0;
+	}
+
+	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
+		pr_err("OPAL: token is not unsigned it: %d\n",
+		       resp->toks[n].type);
+		return 0;
+	}
+	if (!((resp->toks[n].width == OPAL_WIDTH_TINY) ||
+	      (resp->toks[n].width == OPAL_WIDTH_SHORT))) {
+		pr_err("OPAL: atom is not short or tiny: %d\n",
+		       resp->toks[n].width);
+		return 0;
+	}
+
+	return resp->toks[n].stored.u;
+}
+
+static uint8_t response_status(const struct parsed_resp *resp)
+{
+	if ((token_type(resp, 0) == OPAL_DTA_TOKENID_TOKEN)
+	    && (response_get_token(resp, 0) == OPAL_ENDOFSESSION)) {
+		return 0;
+	}
+
+	if (resp->num < 5)
+		return DTAERROR_NO_METHOD_STATUS;
+
+	if ((token_type(resp, resp->num - 1) != OPAL_DTA_TOKENID_TOKEN) ||
+	    (token_type(resp, resp->num - 5) != OPAL_DTA_TOKENID_TOKEN) ||
+	    (response_get_token(resp, resp->num - 1) != OPAL_ENDLIST) ||
+	    (response_get_token(resp, resp->num - 5) != OPAL_STARTLIST))
+		return DTAERROR_NO_METHOD_STATUS;
+
+	return response_get_u64(resp, resp->num - 4);
+}
+
+static int start_opal_session(struct nvme_ns *ns,
+			      uint16_t comID,
+			      uint8_t locking_range,
+			      const uint8_t *key,
+			      uint32_t *hsn, uint32_t *tsn)
+{
+	struct opal_cmd *cmd;
+	int ret;
+	uint32_t HSN, TSN;
+	struct parsed_resp *resp;
+
+	cmd = alloc_opal_cmd();
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
+
+	setComID(cmd, comID);
+
+	if (hsn)
+		HSN = *hsn;
+	else
+		HSN = 105;
+
+	/* STARTSESSION cmd buffer */
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_CALL, token_error);
+	ON_TOKEN_ERROR_GOTO(uid, cmd, OPAL_SMUID_UID, token_error);
+	ON_TOKEN_ERROR_GOTO(method, cmd, OPAL_STARTSESSION, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTLIST, token_error);
+	ON_TOKEN_ERROR_GOTO(u64, cmd, HSN, token_error);
+	ON_TOKEN_ERROR_GOTO(uid, cmd, OPAL_LOCKINGSP_UID, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_TINY_UINT_01, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_TINY_UINT_00, token_error);
+	if (add_token_bytestring(cmd, key, KEY_MAX) < 0) {
+		pr_err("OPAL: [%s:%d] error building command buffer\n",
+		       __func__, __LINE__);
+		goto token_error;
+	}
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_TINY_UINT_03, token_error);
+
+	/* construct Sign Authority for unlocking */
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_SHORT_BYTESTRING8, token_error);
+	if (add_token_array(cmd, &OPALUID[OPAL_USER1_UID][0], 7) < 0) {
+		pr_err("OPAL: [%s:%d] error building command buffer\n",
+		       __func__, __LINE__);
+		goto token_error;
+	}
+	ON_TOKEN_ERROR_GOTO(u8, cmd, locking_range + 1, token_error);
+
+	/* finish cmd buffer */
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDLIST, token_error);
+	ret = cmd_finalize(cmd, 0, 0);
+	if (ret) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: building finalizing command buffer: %d\n", ret);
+		goto free_cmd;
+	}
+
+	print_buffer(&cmd->cmd[0], cmd->pos);
+	ret = nvme_opal_send_cmd(ns, comID,
+				 cmd->cmd, IO_BUFFER_LENGTH,
+				 cmd->resp, IO_BUFFER_LENGTH);
+	if (ret) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Error running command: %d\n", ret);
+		goto free_cmd;
+	}
+
+	resp = response_parse(cmd->resp, IO_BUFFER_LENGTH);
+	if (IS_ERR(resp)) {
+		dev_err(ns->ctrl->dev, "OPAL: Couldn't parse response.\n");
+		ret = PTR_ERR(resp);
+		goto free_cmd;
+	}
+
+	if ((ret = response_status(resp)) != 0) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Start session command status: %d\n", ret);
+		ret = -EINVAL;
+		goto free_resp;
+	}
+
+	HSN = response_get_u64(resp, 4);
+	TSN = response_get_u64(resp, 5);
+
+	if (hsn) *hsn = HSN;
+	if (tsn) *tsn = TSN;
+
+	if (HSN == 0 && TSN == 0) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Couldn't authenticate session\n");
+		ret = -EFAULT;
+	}
+
+free_resp:
+	kfree(resp);
+free_cmd:
+	kfree(cmd);
+	return ret;
+
+token_error:
+	kfree(cmd);
+	return -EFAULT;
+}
+
+static int unlock_locking_range(struct nvme_ns *ns,
+				uint16_t comID,
+				uint8_t locking_range,
+				uint32_t hsn, uint32_t tsn)
+{
+	struct opal_cmd *cmd;
+	int ret;
+	struct parsed_resp *resp;
+
+	cmd = alloc_opal_cmd();
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
+
+	setComID(cmd, comID);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_CALL, token_error);
+	ON_TOKEN_ERROR_GOTO(range, cmd, locking_range, token_error);
+	ON_TOKEN_ERROR_GOTO(method, cmd, OPAL_SET, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTLIST, token_error);
+
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_VALUES, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTLIST, token_error);
+
+	/* enable locking on the range to enforce locking state */
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_READLOCKENABLED, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_TRUE, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_WRITELOCKENABLED, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_TRUE, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+
+	/* set read/write */
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_READLOCKED, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_FALSE, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_STARTNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_WRITELOCKED, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_FALSE, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDLIST, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDNAME, token_error);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDLIST, token_error);
+
+	ret = cmd_finalize(cmd, hsn, tsn);
+	if (ret) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: building finalizing command buffer: %d\n", ret);
+		goto free_cmd;
+	}
+
+	print_buffer(&cmd->cmd[0], cmd->pos);
+
+	ret = nvme_opal_send_cmd(ns, comID,
+				 cmd->cmd, IO_BUFFER_LENGTH,
+				 cmd->resp, IO_BUFFER_LENGTH);
+	if (ret) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Error running erase locking command: %d\n",
+			ret);
+		goto free_cmd;
+	}
+
+	resp = response_parse(cmd->resp, IO_BUFFER_LENGTH);
+	if (IS_ERR(resp)) {
+		dev_err(ns->ctrl->dev, "OPAL: Couldn't parse response.\n");
+		ret = PTR_ERR(resp);
+		goto free_cmd;
+	}
+
+	if ((ret = response_status(resp)) != 0) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: unlock command status: %d\n", ret);
+		ret = -EINVAL;
+		goto free_resp;
+	}
+
+free_resp:
+	kfree(resp);
+free_cmd:
+	kfree(cmd);
+	return ret;
+
+token_error:
+	kfree(cmd);
+	return -EFAULT;
+}
+
+static int end_opal_session(struct nvme_ns *ns,
+			    uint16_t comID,
+			    uint32_t hsn, uint32_t tsn)
+{
+	struct opal_cmd *cmd;
+	int ret;
+	struct parsed_resp *resp;
+
+	cmd = alloc_opal_cmd();
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
+
+	setComID(cmd, comID);
+	ON_TOKEN_ERROR_GOTO(u8, cmd, OPAL_ENDOFSESSION, token_error);
+	ret = cmd_finalize(cmd, hsn, tsn);
+	if (ret) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: building finalizing command buffer: %d\n", ret);
+		goto free_cmd;
+	}
+	print_buffer(&cmd->cmd[0], cmd->pos);
+
+	ret = nvme_opal_send_cmd(ns, comID,
+				 cmd->cmd, IO_BUFFER_LENGTH,
+				 cmd->resp, IO_BUFFER_LENGTH);
+	if (ret) {
+		dev_err(ns->ctrl->dev, "OPAL: Couldn't end session: %d\n", ret);
+		goto free_cmd;
+	}
+
+	resp = response_parse(cmd->resp, IO_BUFFER_LENGTH);
+	if (IS_ERR(resp)) {
+		dev_err(ns->ctrl->dev, "OPAL: Couldn't parse response\n");
+		ret = PTR_ERR(resp);
+		goto free_cmd;
+	}
+
+	if ((ret = response_status(resp)) != 0) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: end session command status: %d\n", ret);
+		ret = -EINVAL;
+		goto free_resp;
+	}
+
+free_resp:
+	kfree(resp);
+free_cmd:
+	kfree(cmd);
+	return ret;
+
+token_error:
+	kfree(cmd);
+	return -EFAULT;
+}
+
+#undef ON_TOKEN_ERROR_RETURN
+#undef ON_TOKEN_ERROR_GOTO
+
+static void release_opal_dev(struct kref *ref)
+{
+	struct nvme_opal_dev *opal_dev;
+	opal_dev = container_of(ref, struct nvme_opal_dev, refcount);
+	kfree(opal_dev);
+}
+
+static int unlock_opal_range_SUM(struct nvme_ns *ns,
+				 struct nvme_opal_dev *opal_dev)
+{
+	int ret;
+	uint32_t hsn, tsn;
+	uint16_t comID = opal_dev->comID;
+	uint8_t lr = opal_dev->locking_range;
+	const uint8_t *key = opal_dev->key;
+
+	hsn = 105;
+
+	if ((ret = start_opal_session(ns, comID, lr, key, &hsn, &tsn)) != 0)
+		return ret;
+
+	if ((ret = unlock_locking_range(ns, comID, lr, hsn, tsn)) != 0)
+		return ret;
+
+	if ((ret = end_opal_session(ns, comID, hsn, tsn)) != 0)
+		return ret;
+
+	dev_info(ns->ctrl->dev,
+		 "OPAL: successfully unlocked ns: %d, range: %d\n",
+		 ns->ns_id, opal_dev->locking_range);
+
+	return ret;
+}
+
+static struct opal_job *opal_job_add(struct nvme_opal_dev *opal_dev,
+				     struct list_head *list)
+{
+	struct opal_job *job;
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&job->node);
+	job->dev = opal_dev;
+	list_add_tail(&job->node, list);
+	kref_get(&job->dev->refcount);
+
+	return job;
+}
+
+static struct opal_job *get_next_unlock_job(struct list_head *list)
+{
+	struct opal_job *job;
+
+	job = list_first_entry_or_null(list, struct opal_job, node);
+	if (job)
+		list_del(&job->node);
+
+	return job;
+}
+
+int nvme_opal_unlock(struct nvme_ns *ns)
+{
+	struct nvme_opal_dev *iter;
+	struct opal_job *job;
+	LIST_HEAD(unlock_list);
+
+	mutex_lock(&opal_list_mutex);
+	list_for_each_entry(iter, &opal_list, node) {
+		if (!strncmp(iter->serial, ns->ctrl->serial,
+			     sizeof(iter->serial))
+		    && !strncmp(iter->model, ns->ctrl->model,
+				sizeof(iter->model))
+		    && iter->nsid == ns->ns_id)
+			opal_job_add(iter, &unlock_list);
+	}
+	mutex_unlock(&opal_list_mutex);
+
+	while ((job = get_next_unlock_job(&unlock_list)) != NULL) {
+		unlock_opal_range_SUM(ns, job->dev);
+		kref_put(&job->dev->refcount, release_opal_dev);
+		kfree(job);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(nvme_opal_unlock);
+
+static struct nvme_opal_dev *alloc_opal_dev(struct nvme_ns *ns,
+					    uint8_t locking_range,
+					    uint16_t comID)
+{
+	struct nvme_opal_dev *opal_dev;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	opal_dev = kzalloc(sizeof(*opal_dev), GFP_KERNEL);
+	if (!opal_dev)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&opal_dev->refcount);
+	INIT_LIST_HEAD(&opal_dev->node);
+
+	memcpy(opal_dev->serial, ctrl->serial, sizeof(opal_dev->serial));
+	memcpy(opal_dev->model, ctrl->model, sizeof(opal_dev->model));
+	opal_dev->nsid = ns->ns_id;
+	opal_dev->locking_range = locking_range;
+	opal_dev->comID = comID;
+
+	list_add_tail(&opal_dev->node, &opal_list);
+
+	return opal_dev;
+}
+
+static struct nvme_opal_dev *find_opal_dev(struct nvme_ns *ns,
+					   uint8_t locking_range)
+{
+	struct nvme_opal_dev *iter, *opal_dev = NULL;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	list_for_each_entry(iter, &opal_list, node) {
+		if (!strncmp(iter->serial, ctrl->serial, sizeof(iter->serial))
+		    && !strncmp(iter->model, ctrl->model, sizeof(iter->model))
+		    && (iter->nsid == ns->ns_id)
+		    && (iter->locking_range == locking_range)) {
+			opal_dev = iter;
+			break;
+		}
+	}
+
+	return opal_dev;
+}
+
+int nvme_opal_register(struct nvme_ns *ns,
+		       struct nvme_opal_key __user *arg)
+{
+	struct nvme_opal_dev *opal_dev = NULL;
+	struct nvme_opal_key cmd;
+	int ret = 0;
+	uint32_t hsn = 105, tsn;
+	uint16_t comID;
+
+	if (copy_from_user(&cmd, arg, sizeof(cmd)))
+		return -EFAULT;
+
+	if ((ret = nvme_opal_discovery0(ns, &comID)) != 0) {
+		dev_err(ns->ctrl->dev, "OPAL: Discovery0 failed.\n");
+		return ret;
+	}
+
+	if ((ret = start_opal_session(ns, comID, cmd.locking_range, cmd.key,
+				      &hsn, &tsn)) != 0) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Could not authenticate key\n");
+		return ret;
+	}
+
+	if ((ret = end_opal_session(ns, comID, hsn, tsn)) != 0) {
+		dev_err(ns->ctrl->dev, "OPAL: Could not end session\n");
+		return ret;
+	}
+
+	mutex_lock(&opal_list_mutex);
+
+	opal_dev = find_opal_dev(ns, cmd.locking_range);
+	if (!opal_dev)
+		opal_dev = alloc_opal_dev(ns, cmd.locking_range, comID);
+
+	if (IS_ERR(opal_dev)) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Error registering device: allocation\n");
+		ret =  PTR_ERR(opal_dev);
+		goto unlock_exit;
+	}
+
+	if (!memcpy(opal_dev->key, cmd.key, sizeof(opal_dev->key))) {
+		dev_err(ns->ctrl->dev,
+			"OPAL: Error registering device: copying key\n");
+		ret = -EFAULT;
+		list_del(&opal_dev->node);
+		kref_put(&opal_dev->refcount, release_opal_dev);
+	}
+
+unlock_exit:
+	mutex_unlock(&opal_list_mutex);
+
+	if (ret == 0)
+		dev_info(ns->ctrl->dev,
+			 "OPAL: Registered key for locking range: %d\n",
+			 cmd.locking_range);
+
+	return ret;
+}
+EXPORT_SYMBOL(nvme_opal_register);
+
+void nvme_opal_unregister(struct nvme_ns *ns, uint8_t locking_range)
+{
+	struct nvme_opal_dev *opal_dev;
+
+	opal_dev = find_opal_dev(ns, locking_range);
+	if (!opal_dev)
+		return;
+
+	mutex_lock(&opal_list_mutex);
+	list_del(&opal_dev->node);
+	kref_put(&opal_dev->refcount, release_opal_dev);
+	mutex_unlock(&opal_list_mutex);
+}
+EXPORT_SYMBOL(nvme_opal_unregister);
+
+int __init nvme_opal_init(void)
+{
+	return 0;
+}
+EXPORT_SYMBOL(nvme_opal_init);
+
+static struct nvme_opal_dev *get_next_opal_dev(void)
+{
+	return list_first_entry_or_null(&opal_list, struct nvme_opal_dev, node);
+}
+
+void nvme_opal_exit(void)
+{
+	struct nvme_opal_dev *dev;
+
+	mutex_lock(&opal_list_mutex);
+	while ((dev = get_next_opal_dev()) != NULL) {
+		list_del(&dev->node);
+		kref_put(&dev->refcount, release_opal_dev);
+	}
+	mutex_unlock(&opal_list_mutex);
+
+}
+EXPORT_SYMBOL(nvme_opal_exit);
diff --git a/drivers/nvme/host/opal.h b/drivers/nvme/host/opal.h
new file mode 100644
index 0000000..66f0137
--- /dev/null
+++ b/drivers/nvme/host/opal.h
@@ -0,0 +1,73 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ */
+
+#ifndef _NVME_OPAL_H
+#define _NVME_OPAL_H
+
+#include <linux/nvme_ioctl.h>
+/* TODO: Put this inside ifdef.
+ * Need to make function parameters more opaque.
+ */
+#include "nvme.h"
+
+#ifdef CONFIG_BLK_DEV_NVME_OPAL
+
+int nvme_opal_init(void);
+void nvme_opal_exit(void);
+
+int nvme_opal_register(struct nvme_ns *ns, struct nvme_opal_key __user *arg);
+void nvme_opal_unregister(struct nvme_ns *ns, uint8_t locking_range);
+
+int nvme_opal_unlock(struct nvme_ns *ns);
+
+#else
+
+static inline int nvme_opal_init(void)
+{
+	return 0;
+}
+
+static inline void nvme_opal_exit(void)
+{
+}
+
+static inline int nvme_opal_register(struct nvme_ns *ns, struct nvme_opal_key __user *arg)
+{
+	return -ENOTTY;
+}
+
+static inline void nvme_opal_unregister(struct nvme_ns *ns, uint8_t locking_range)
+{
+}
+
+static inline int nvme_opal_unlock(struct nvme_ns *ns)
+{
+	return -ENOTTY;
+}
+
+#endif
+
+#endif /* _NVME_OPAL_H */
diff --git a/drivers/nvme/host/opal_internal.h b/drivers/nvme/host/opal_internal.h
new file mode 100644
index 0000000..7258f68
--- /dev/null
+++ b/drivers/nvme/host/opal_internal.h
@@ -0,0 +1,501 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ */
+
+#ifndef _NVME_OPAL_INTERNAL_H
+#define _NVME_OPAL_INTERNAL_H
+
+#include "opal.h"
+
+#define DTAERROR_NO_METHOD_STATUS 0x89
+
+/* User IDs used in the TCG storage SSCs */
+static const uint8_t OPALUID[][8] = {
+	/* users */
+	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff}, /* session management  */
+	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 }, /* special "thisSP" syntax */
+	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x01 }, /* Administrative SP */
+	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x00, 0x00, 0x02 }, /* Locking SP */
+	{ 0x00, 0x00, 0x02, 0x05, 0x00, 0x01, 0x00, 0x01 }, /* ENTERPRISE Locking SP  */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x01 }, /* anybody */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x06 }, /* SID */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0x00, 0x01 }, /* ADMIN1 */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x01 }, /* USER1 */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x03, 0x00, 0x02 }, /* USER2 */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x01, 0xff, 0x01 }, /* PSID user */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x80, 0x01 }, /* BandMaster 0 */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 }, /* EraseMaster */
+	/* tables */
+	{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 }, /* Locking_GlobalRange */
+	{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE0, 0x01 }, /* ACE_Locking_Range_Set_RdLocked UID */
+	{ 0x00, 0x00, 0x00, 0x08, 0x00, 0x03, 0xE8, 0x01 }, /* ACE_Locking_Range_Set_WrLocked UID */
+	{ 0x00, 0x00, 0x08, 0x03, 0x00, 0x00, 0x00, 0x01 }, /* MBR Control */
+	{ 0x00, 0x00, 0x08, 0x04, 0x00, 0x00, 0x00, 0x00 }, /* Shadow MBR */
+	{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x00, 0x00}, /* AUTHORITY_TABLE */
+	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x00}, /* C_PIN_TABLE */
+	{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x01 }, /* OPAL Locking Info */
+	{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 }, /* Enterprise Locking Info */
+	/* C_PIN_TABLE object ID's */
+	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02}, /* C_PIN_MSID */
+	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x00, 0x01}, /* C_PIN_SID */
+	{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01}, /* C_PIN_ADMIN1 */
+	/* half UID's (only first 4 bytes used) */
+	{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff }, /* Half-UID ? Authority_object_ref */
+	{ 0x00, 0x00, 0x04, 0x0E, 0xff, 0xff, 0xff, 0xff }, /* Half-UID ? Boolean ACE */
+	/* special value for omitted optional parameter */
+	{ 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}, /* HEXFF for omitted */
+};
+
+/* Enum to index OPALUID array */
+enum OPAL_UID {
+	/* users */
+	OPAL_SMUID_UID,
+	OPAL_THISSP_UID,
+	OPAL_ADMINSP_UID,
+	OPAL_LOCKINGSP_UID,
+	OPAL_ENTERPRISE_LOCKINGSP_UID,
+	OPAL_ANYBODY_UID,
+	OPAL_SID_UID,
+	OPAL_ADMIN1_UID,
+	OPAL_USER1_UID,
+	OPAL_USER2_UID,
+	OPAL_PSID_UID,
+	OPAL_ENTERPRISE_BANDMASTER0_UID,
+	OPAL_ENTERPRISE_ERASEMASTER_UID,
+	/* tables */
+	OPAL_LOCKINGRANGE_GLOBAL,
+	OPAL_LOCKINGRANGE_ACE_RDLOCKED,
+	OPAL_LOCKINGRANGE_ACE_WRLOCKED,
+	OPAL_MBRCONTROL,
+	OPAL_MBR,
+	OPAL_AUTHORITY_TABLE,
+	OPAL_C_PIN_TABLE,
+	OPAL_LOCKING_INFO_TABLE,
+	OPAL_ENTERPRISE_LOCKING_INFO_TABLE,
+	/* C_PIN_TABLE object ID's */
+	OPAL_C_PIN_MSID,
+	OPAL_C_PIN_SID,
+	OPAL_C_PIN_ADMIN1,
+	/* half UID's (only first 4 bytes used) */
+	OPAL_HALF_UID_AUTHORITY_OBJ_REF,
+	OPAL_HALF_UID_BOOLEAN_ACE,
+	/* omitted optional parameter */
+	OPAL_UID_HEXFF,
+};
+
+/*
+ * TCG Storage SSC Methods.
+ */
+static const uint8_t OPALMETHOD[][8] = {
+	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x01 }, /* Properties */
+	{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x02 }, /* STARTSESSION */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x02 }, /* Revert */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x02, 0x03 }, /* Activate */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x06 }, /* Enterprise Get */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x07 }, /* Enterprise Set */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x08 }, /* NEXT */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0c }, /* Enterprise Authenticate */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x0d }, /* GetACL */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x10 }, /* GenKey */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x11 }, /* revertSP */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x16 }, /* Get */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x17 }, /* Set */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 0x1c }, /* Authenticate */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x06, 0x01 }, /* Random */
+	{ 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x08, 0x03 }, /* Erase */
+};
+
+/* Enum for indexing the OPALMETHOD array */
+enum OPAL_METHOD {
+	OPAL_PROPERTIES,
+	OPAL_STARTSESSION,
+	OPAL_REVERT,
+	OPAL_ACTIVATE,
+	OPAL_EGET,
+	OPAL_ESET,
+	OPAL_NEXT,
+	OPAL_EAUTHENTICATE,
+	OPAL_GETACL,
+	OPAL_GENKEY,
+	OPAL_REVERTSP,
+	OPAL_GET,
+	OPAL_SET,
+	OPAL_AUTHENTICATE,
+	OPAL_RANDOM,
+	OPAL_ERASE,
+};
+
+enum OPAL_RESPONSE_TOKEN {
+	OPAL_DTA_TOKENID_BYTESTRING = 0xe0,
+	OPAL_DTA_TOKENID_SINT = 0xe1,
+	OPAL_DTA_TOKENID_UINT = 0xe2,
+	OPAL_DTA_TOKENID_TOKEN = 0xe3, /* actual token is returned */
+	OPAL_DTA_TOKENID_INVALID = 0X0
+};
+
+/*
+ * TODO: Split this enum
+ * Apparently these different types of enums were grouped together so they
+ * could be matched in a single C++ method. Since we don't have polymorphism in
+ * C, and we are going to cast it to uint8_t anyway, there's no need to keep
+ * these enums, and we can split them into separate declarations.
+ */
+enum OPAL_TOKEN {
+	/* Boolean */
+	OPAL_TRUE = 0x01,
+	OPAL_FALSE = 0x00,
+	OPAL_BOOLEAN_EXPR = 0x03,
+	/* cellblocks */
+	OPAL_TABLE = 0x00,
+	OPAL_STARTROW = 0x01,
+	OPAL_ENDROW = 0x02,
+	OPAL_STARTCOLUMN = 0x03,
+	OPAL_ENDCOLUMN = 0x04,
+	OPAL_VALUES = 0x01,
+	/* authority table */
+	OPAL_PIN = 0x03,
+	/* locking tokens */
+	OPAL_RANGESTART = 0x03,
+	OPAL_RANGELENGTH = 0x04,
+	OPAL_READLOCKENABLED = 0x05,
+	OPAL_WRITELOCKENABLED = 0x06,
+	OPAL_READLOCKED = 0x07,
+	OPAL_WRITELOCKED = 0x08,
+	OPAL_ACTIVEKEY = 0x0A,
+	/* locking info table */
+	OPAL_MAXRANGES = 0x04,
+	 /* mbr control */
+	OPAL_MBRENABLE = 0x01,
+	OPAL_MBRDONE = 0x02,
+	/* properties */
+	OPAL_HOSTPROPERTIES =0x00,
+	/* atoms */
+	OPAL_STARTLIST = 0xf0,
+	OPAL_ENDLIST = 0xf1,
+	OPAL_STARTNAME = 0xf2,
+	OPAL_ENDNAME = 0xf3,
+	OPAL_CALL = 0xf8,
+	OPAL_ENDOFDATA = 0xf9,
+	OPAL_ENDOFSESSION = 0xfa,
+	OPAL_STARTTRANSACTON = 0xfb,
+	OPAL_ENDTRANSACTON = 0xfC,
+	OPAL_EMPTYATOM = 0xff,
+	OPAL_WHERE = 0x00,
+};
+
+/* Useful tiny atoms.
+ * Useful for table columns etc
+ */
+enum OPAL_TINY_ATOM {
+	OPAL_TINY_UINT_00 = 0x00,
+	OPAL_TINY_UINT_01 = 0x01,
+	OPAL_TINY_UINT_02 = 0x02,
+	OPAL_TINY_UINT_03 = 0x03,
+	OPAL_TINY_UINT_04 = 0x04,
+	OPAL_TINY_UINT_05 = 0x05,
+	OPAL_TINY_UINT_06 = 0x06,
+	OPAL_TINY_UINT_07 = 0x07,
+	OPAL_TINY_UINT_08 = 0x08,
+	OPAL_TINY_UINT_09 = 0x09,
+	OPAL_TINY_UINT_10 = 0x0a,
+	OPAL_TINY_UINT_11 = 0x0b,
+	OPAL_TINY_UINT_12 = 0x0c,
+	OPAL_TINY_UINT_13 = 0x0d,
+	OPAL_TINY_UINT_14 = 0x0e,
+	OPAL_TINY_UINT_15 = 0x0f,
+};
+
+/*
+ * Useful short atoms.
+ */
+enum OPAL_SHORT_ATOM {
+	OPAL_SHORT_UINT_3 = 0x83,
+	OPAL_SHORT_BYTESTRING4 = 0xa4,
+	OPAL_SHORT_BYTESTRING8 = 0xa8,
+};
+
+enum OPAL_ATOM_WIDTH {
+	OPAL_WIDTH_TINY,
+	OPAL_WIDTH_SHORT,
+	OPAL_WIDTH_MEDIUM,
+	OPAL_WIDTH_LONG,
+	OPAL_WIDTH_TOKEN
+};
+
+/* Locking state for a locking range */
+enum OPAL_LOCKINGSTATE {
+	OPAL_LOCKING_READWRITE = 0x01,
+	OPAL_LOCKING_READONLY = 0x02,
+	OPAL_LOCKING_LOCKED = 0x03,
+};
+
+/*
+ * Structures to build and decode the Opal SSC messages
+ * fields that are NOT really numeric are defined as uint8_t[] to
+ * help reduce the endianess issues
+ */
+
+/* Comm Packet (header) for transmissions. */
+struct opal_compacket {
+	uint32_t reserved0;
+	uint8_t extendedComID[4];
+	uint32_t outstandingData;
+	uint32_t minTransfer;
+	uint32_t length;
+};
+
+/* Packet structure. */
+struct opal_packet {
+	uint32_t TSN;
+	uint32_t HSN;
+	uint32_t seq_number;
+	uint16_t reserved0;
+	uint16_t ack_type;
+	uint32_t acknowledgement;
+	uint32_t length;
+};
+
+/* Data sub packet header */
+struct opal_data_subpacket {
+	uint8_t reserved0[6];
+	uint16_t kind;
+	uint32_t length;
+};
+
+/* header of a response */
+struct opal_header {
+	struct opal_compacket cp;
+	struct opal_packet pkt;
+	struct opal_data_subpacket subpkt;
+};
+
+#define FC_TPER       0x0001
+#define FC_LOCKING    0x0002
+#define FC_GEOMETRY   0x0003
+#define FC_ENTERPRISE 0x0100
+#define FC_DATASTORE  0x0202
+#define FC_SINGLEUSER 0x0201
+#define FC_OPALV100   0x0200
+#define FC_OPALV200   0x0203
+
+/*
+ * The Discovery 0 Header. As defined in
+ * Opal SSC Documentation
+ */
+struct d0_header {
+	uint32_t length; /* the length of the header 48 in 2.00.100 */
+	uint32_t revision; /**< revision of the header 1 in 2.00.100 */
+	uint32_t reserved01;
+	uint32_t reserved02;
+	/*
+	 * the remainder of the structure is vendor specific and will not be
+	 * addressed now
+	 */
+};
+
+/*
+ * TPer Feature Descriptor. Contains flags indicating support for the
+ * TPer features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x001 in 2.00.100
+ */
+struct d0_tper_features {
+	/*
+	 * supported_features bits:
+	 * bit 7: reserved
+	 * bit 6: com ID management
+	 * bit 5: reserved
+	 * bit 4: streaming support
+	 * bit 3: buffer management
+	 * bit 2: ACK/NACK
+	 * bit 1: async
+	 * bit 0: sync
+	 */
+	uint8_t supported_features;
+	/*
+	 * bytes 5 through 15 are reserved, but we represent the first 3 as
+	 * uint8_t to keep the other two 32bits integers aligned.
+	 */
+	uint8_t reserved01[3];
+	uint32_t reserved02;
+	uint32_t reserved03;
+};
+
+/*
+ * Locking Feature Descriptor. Contains flags indicating support for the
+ * locking features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x0002 in 2.00.100
+ */
+struct d0_locking_features {
+	/*
+	 * supported_features bits:
+	 * bits 6-7: reserved
+	 * bit 5: MBR done
+	 * bit 4: MBR enabled
+	 * bit 3: media encryption
+	 * bit 2: locked
+	 * bit 1: locking enabled
+	 * bit 0: locking supported
+	 */
+	uint8_t supported_features;
+	/*
+	 * bytes 5 through 15 are reserved, but we represent the first 3 as
+	 * uint8_t to keep the other two 32bits integers aligned.
+	 */
+	uint8_t reserved01[3];
+	uint32_t reserved02;
+	uint32_t reserved03;
+};
+
+/*
+ * Geometry Feature Descriptor. Contains flags indicating support for the
+ * geometry features described in the OPAL specification. The names match the
+ * OPAL terminology
+ *
+ * code == 0x0003 in 2.00.100
+ */
+struct d0_geometry_features {
+	/*
+	 * reserved01:
+	 * bits 1-6: reserved
+	 * bit 0: align
+	 */
+	uint8_t reserved01;
+	uint8_t reserved02[7];
+	uint32_t logical_block_size;
+	uint64_t alignment_granularity;
+	uint64_t lowest_aligned_lba;
+};
+
+/*
+ * Enterprise SSC Feature
+ *
+ * code == 0x0100
+ */
+struct d0_enterprise_ssc {
+	uint16_t baseComID;
+	uint16_t numComIDs;
+	/* range_crossing:
+	 * bits 1-6: reserved
+	 * bit 0: range crossing
+	 */
+	uint8_t range_crossing;
+	uint8_t reserved01;
+	uint16_t reserved02;
+	uint32_t reserved03;
+	uint32_t reserved04;
+};
+
+/*
+ * Opal V1 feature
+ *
+ * code == 0x0200
+ */
+struct d0_opal_v100 {
+	uint16_t baseComID;
+	uint16_t numComIDs;
+};
+
+/*
+ * Single User Mode feature
+ *
+ * code == 0x0201
+ */
+struct d0_single_user_mode {
+	uint32_t num_locking_objects;
+	/* reserved01:
+	 * bit 0: any
+	 * bit 1: all
+	 * bit 2: policy
+	 * bits 3-7: reserved
+	 */
+	uint8_t reserved01;
+	uint8_t reserved02;
+	uint16_t reserved03;
+	uint32_t reserved04;
+};
+
+/*
+ * Additonal Datastores feature
+ *
+ * code == 0x0202
+ */
+struct d0_datastore_table {
+	uint16_t reserved01;
+	uint16_t max_tables;
+	uint32_t max_size_tables;
+	uint32_t table_size_alignment;
+};
+
+/*
+ * OPAL 2.0 feature
+ *
+ * code == 0x0203
+ */
+struct d0_opal_v200 {
+	uint16_t baseComID;
+	uint16_t numComIDs;
+	/* range_crossing:
+	 * bits 1-6: reserved
+	 * bit 0: range crossing
+	 */
+	uint8_t range_crossing;
+	/* num_locking_admin_auth:
+	 * not aligned to 16 bits, so use two uint8_t.
+	 * stored in big endian:
+	 * 0: MSB
+	 * 1: LSB
+	 */
+	uint8_t num_locking_admin_auth[2];
+	/* num_locking_user_auth:
+	 * not aligned to 16 bits, so use two uint8_t.
+	 * stored in big endian:
+	 * 0: MSB
+	 * 1: LSB
+	 */
+	uint8_t num_locking_user_auth[2];
+	uint8_t initialPIN;
+	uint8_t revertedPIN;
+	uint8_t reserved01;
+	uint32_t reserved02;
+};
+
+/* Union of features used to parse the discovery 0 response */
+struct d0_features {
+	uint16_t code;
+	/*
+	 * r_version bits:
+	 * bits 4-7: version
+	 * bits 0-3: reserved
+	 */
+	uint8_t r_version;
+	uint8_t length;
+	uint8_t features[];
+};
+
+#endif /* _NVME_OPAL_INTERNAL_H */
-- 
1.9.1
