Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E3EFAD3E2
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QeV9TE2ngY4Zt865X5bEfPX0qJ7FYU//Wz7XfPdbPk8=; b=vPEpyFufmMeiM7wCqG102AxtnT
	N/Ggn/NJ95V/p5C4ANeJgb2TI8Wpo4wk2eEZSnz6iplxN5rWp2/S7KeL7mZ99/Eao0NSnyVSEdYyL
	5XNQzOSpwJzLLWHUTBicWVb5g02TiPU8pkGv5tmpPb8CdhvGlEwA+ioIVe5+vwUDpwYKMy6wWXmbA
	sqLZvenjVs6+Mtlqw0fDA5zi+n4DyciZJooetjwkK67MBySgeUIHan3QiJMHPYthxXjUSwg2+99F2
	8sABPd5ettPZ7cTSDQD2p8PQqKvOk08znvG0AHNsORosSXjML4oQZ0yjaX/5wyZcCUNSXWIU4yvnN
	qFy4IgFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFgjA-0000000Aoxt-1RFw;
	Wed, 22 Apr 2026 23:11:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFgj5-0000000Aowc-41Kk
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 23:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776899483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeV9TE2ngY4Zt865X5bEfPX0qJ7FYU//Wz7XfPdbPk8=;
	b=VJ1cEiS67PTq20TnKzLEJm68+aGAIDYmh8g+ynsT3n6Kc33w11w0AOfymzXtVnjjztqJXU
	jDf8OEmSsjuAzNNTjhOKQ88VyZGUsgMPbOrrTkaYoMK1G2piquQhCERG3QoQRdRg5NJ7et
	ivo4Tst9cXAVnarP7WykNtZZV0Z9OoM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-MBjWA0VnNjGJ2L7fCMS2BA-1; Wed,
 22 Apr 2026 19:11:19 -0400
X-MC-Unique: MBjWA0VnNjGJ2L7fCMS2BA-1
X-Mimecast-MFC-AGG-ID: MBjWA0VnNjGJ2L7fCMS2BA_1776899478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501421956080;
	Wed, 22 Apr 2026 23:11:18 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.2.17.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 199261956095;
	Wed, 22 Apr 2026 23:11:16 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: [RFC PATCH] nvme-keyring: add request_key upcalls for dynamic key loading
Date: Wed, 22 Apr 2026 16:10:22 -0700
Message-ID: <20260422231043.2689681-2-cleech@redhat.com>
In-Reply-To: <20260422231043.2689681-1-cleech@redhat.com>
References: <20260422231043.2689681-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fkBJVDXKRyX1EuzSzz0gEhY6gTd0H_No0XpOVKkU4m8_1776899478
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_161124_138374_EE3A009E 
X-CRM114-Status: GOOD (  25.19  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a prototype of a "PSK request" key type, which requests one or
more PSKs for a host NQN, subsystem NQN pair.  The matching PSKs and
needed metadata to recreate the correct identity are returned from the
request_key upcall, the unpacked into new psk keys in the nvme keyring.

Assisted-by: Claude:claude-sonnet-4.5
---
 drivers/nvme/common/keyring.c | 373 +++++++++++++++++++++++++++++++++-
 1 file changed, 372 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 32d16c53133be..22fb64cbe16ef 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -7,12 +7,36 @@
 #include <linux/seq_file.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
+#include <linux/base64.h>
 #include <linux/nvme.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/nvme-auth.h>
 
 static struct key *nvme_keyring;
 
+/*
+ * Parsed PSK entry from binary payload.
+ */
+struct nvme_psk_entry {
+	u8 version;
+	u8 hmac;
+	u8 key_len;
+	u8 digest_len;
+	u8 key_data[48];
+	u8 digest[48];
+};
+
+/*
+ * Payload for nvme-psk-request key type.
+ * Stores parsed PSK entries from binary payload.
+ */
+struct psk_request_payload {
+	struct rcu_head rcu;
+	int psk_count;
+	struct nvme_psk_entry psk_entries[];
+};
+
 key_serial_t nvme_keyring_id(void)
 {
 	return nvme_keyring->serial;
@@ -77,7 +101,6 @@ static int nvme_tls_psk_match_preparse(struct key_match_data *match_data)
 
 static struct key_type nvme_tls_psk_key_type = {
 	.name           = "psk",
-	.flags          = KEY_TYPE_NET_DOMAIN,
 	.preparse       = user_preparse,
 	.free_preparse  = user_free_preparse,
 	.match_preparse = nvme_tls_psk_match_preparse,
@@ -88,6 +111,193 @@ static struct key_type nvme_tls_psk_key_type = {
 	.read           = user_read,
 };
 
+/*
+ * nvme-psk-request key type callbacks
+ */
+
+/*
+ * parse_binary_psk_payload - Parse binary PSK payload
+ * @payload: Binary PSK payload
+ * @paylen: Length of @payload
+ * @entries: Destination pointer for allocated PSK entry array
+ * @count: Destination for number of PSKs parsed
+ *
+ * Parses a binary payload containing one or more PSKs.
+ * Format per PSK: hmac(1) + key_len(1) + key_data[key_len]
+ *
+ * Returns 0 on success with *entries allocated and *count set.
+ * Returns negative error code if no valid PSKs found.
+ */
+static int parse_binary_psk_payload(const u8 *payload, size_t paylen,
+				     struct nvme_psk_entry **entries,
+				     int *count)
+{
+	const u8 *p = payload;
+	const u8 *end = payload + paylen;
+	struct nvme_psk_entry *temp_entries;
+	int n = 0, idx = 0;
+	const u8 *scan;
+
+	if (!payload || paylen == 0)
+		return -EINVAL;
+
+	/* Count entries first */
+	scan = p;
+	while (scan < end) {
+		u8 key_len, digest_len;
+
+		if (scan + 3 > end)
+			break;
+
+		key_len = scan[1];
+		digest_len = scan[2];
+
+		if (key_len > 48 || digest_len > 48 ||
+		    scan + 3 + key_len + digest_len > end) {
+			pr_debug("invalid PSK entry at offset %ld: key_len=%u digest_len=%u\n",
+				 scan - payload, key_len, digest_len);
+			break;
+		}
+		n++;
+		scan += 3 + key_len + digest_len;
+	}
+
+	if (n == 0)
+		return -EINVAL;
+
+	/* Allocate array */
+	temp_entries = kvmalloc_objs(*temp_entries, n, GFP_KERNEL);
+	if (!temp_entries)
+		return -ENOMEM;
+
+	/* Parse each PSK */
+	while (p < end) {
+		u8 hmac, key_len, digest_len;
+
+		if (p + 3 > end)
+			break;
+
+		hmac = p[0];
+		key_len = p[1];
+		digest_len = p[2];
+		p += 3;
+
+		if (key_len > 48 || digest_len > 48 ||
+		    p + key_len + digest_len > end) {
+			pr_debug("truncated PSK entry: key_len=%u digest_len=%u, remaining=%ld\n",
+				 key_len, digest_len, end - p);
+			break;
+		}
+
+		temp_entries[idx].version = 1;
+		temp_entries[idx].hmac = hmac;
+		temp_entries[idx].key_len = key_len;
+		temp_entries[idx].digest_len = digest_len;
+		memcpy(temp_entries[idx].key_data, p, key_len);
+		p += key_len;
+		memcpy(temp_entries[idx].digest, p, digest_len);
+		p += digest_len;
+		idx++;
+	}
+
+	if (idx == 0) {
+		kvfree(temp_entries);
+		return -EINVAL;
+	}
+
+	*entries = temp_entries;
+	*count = idx;
+	return 0;
+}
+
+static int psk_request_preparse(struct key_preparsed_payload *prep)
+{
+	struct psk_request_payload *payload;
+	struct nvme_psk_entry *entries;
+	int count, ret;
+	size_t payload_size;
+
+	/* Parse binary PSK payload */
+	ret = parse_binary_psk_payload(prep->data, prep->datalen, &entries, &count);
+	if (ret)
+		return ret;
+
+	/* Allocate payload structure with flexible array */
+	payload_size = sizeof(*payload) + count * sizeof(struct nvme_psk_entry);
+	payload = kzalloc(payload_size, GFP_KERNEL);
+	if (!payload) {
+		kvfree(entries);
+		return -ENOMEM;
+	}
+
+	payload->psk_count = count;
+	memcpy(payload->psk_entries, entries, count * sizeof(*entries));
+	kvfree(entries);
+
+	prep->quotalen = payload_size;
+	prep->payload.data[0] = payload;
+
+	return 0;
+}
+
+static void psk_request_free_preparse(struct key_preparsed_payload *prep)
+{
+	kfree(prep->payload.data[0]);
+}
+
+static int psk_request_instantiate(struct key *key,
+				    struct key_preparsed_payload *prep)
+{
+	int ret;
+
+	ret = key_payload_reserve(key, prep->quotalen);
+	if (ret == 0) {
+		rcu_assign_keypointer(key, prep->payload.data[0]);
+		prep->payload.data[0] = NULL;
+	}
+	return ret;
+}
+
+static void psk_request_destroy(struct key *key)
+{
+	struct psk_request_payload *payload;
+
+	payload = rcu_access_pointer(key->payload.rcu_data0);
+	kfree(payload);
+}
+
+static void psk_request_describe(const struct key *key, struct seq_file *m)
+{
+	seq_puts(m, "nvme-psk-request: ");
+	seq_puts(m, key->description);
+}
+
+static long psk_request_read(const struct key *key, char *buffer,
+			      size_t buflen)
+{
+	struct psk_request_payload *payload;
+	long ret;
+
+	payload = dereference_key_locked(key);
+	if (!payload)
+		return -EKEYREVOKED;
+
+	/* Return PSK count for debugging */
+	ret = scnprintf(buffer, buflen, "psk_count=%d\n", payload->psk_count);
+
+	return ret;
+}
+
+static struct key_type nvme_tls_psk_request_key_type = {
+	.name           = "nvme-psk-request",
+	.preparse       = psk_request_preparse,
+	.free_preparse  = psk_request_free_preparse,
+	.instantiate    = psk_request_instantiate,
+	.destroy        = psk_request_destroy,
+	.describe       = psk_request_describe,
+	.read           = psk_request_read,
+};
+
 static struct key *nvme_tls_psk_lookup(struct key *keyring,
 		const char *hostnqn, const char *subnqn,
 		u8 hmac, u8 psk_ver, bool generated)
@@ -123,6 +333,151 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+/*
+ * nvme_tls_psk_request - Request PSK via userspace upcall
+ * @keyring: Target keyring for PSKs
+ * @hostnqn: Host NQN
+ * @subnqn: Subsystem NQN
+ *
+ * Invokes a userspace upcall via request_key() to obtain PSKs.
+ * Userspace returns a binary payload containing one or more PSKs.
+ * Binary format per PSK: hmac(1) + key_len(1) + key_data[key_len]
+ * This function parses the payload and creates PSK keys in the
+ * target keyring with full identities.
+ *
+ * Returns the serial of the first PSK created, or 0 on failure.
+ */
+static key_serial_t nvme_tls_psk_request(struct key *keyring,
+					  const char *hostnqn,
+					  const char *subnqn)
+{
+	char *description = NULL;
+	char *callout_info = NULL;
+	size_t description_len, callout_len;
+	struct key *req_key = NULL;
+	struct psk_request_payload *payload;
+	key_serial_t first_psk_serial = 0;
+	key_serial_t keyring_id;
+	int i;
+
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+
+	/* Build simple description: "<hostnqn> <subnqn>" */
+	description_len = strlen(hostnqn) + strlen(subnqn) + 2;
+	description = kzalloc(description_len, GFP_KERNEL);
+	if (!description)
+		return 0;
+
+	snprintf(description, description_len, "%s %s", hostnqn, subnqn);
+
+	/* Build callout info: "hostnqn=... subnqn=..." */
+	callout_len = strlen("hostnqn=") + strlen(hostnqn) +
+		      strlen(" subnqn=") + strlen(subnqn) + 1;
+	callout_info = kzalloc(callout_len, GFP_KERNEL);
+	if (!callout_info) {
+		kfree(description);
+		return 0;
+	}
+
+	snprintf(callout_info, callout_len, "hostnqn=%s subnqn=%s",
+		 hostnqn, subnqn);
+
+	pr_debug("keyring %x request PSKs for '%s'\n", keyring_id, description);
+
+	/* Request key from userspace */
+	req_key = request_key(&nvme_tls_psk_request_key_type,
+			       description, callout_info);
+	if (IS_ERR(req_key)) {
+		pr_debug("request_key failed for '%s', error %ld\n",
+			 description, PTR_ERR(req_key));
+		goto out_free;
+	}
+
+	/* Extract parsed PSKs from request key payload */
+	down_read(&req_key->sem);
+	payload = dereference_key_locked(req_key);
+	if (!payload) {
+		up_read(&req_key->sem);
+		pr_debug("request key has no payload\n");
+		goto out_put_req;
+	}
+
+	pr_debug("received %d PSK(s) from upcall\n", payload->psk_count);
+
+	/* Create each PSK in target keyring */
+	for (i = 0; i < payload->psk_count; i++) {
+		struct nvme_psk_entry *psk = &payload->psk_entries[i];
+		char *identity = NULL;
+		char *digest_b64 = NULL;
+		key_ref_t keyref;
+		struct key *key;
+		key_perm_t keyperm = KEY_POS_SEARCH | KEY_POS_VIEW |
+				     KEY_POS_READ | KEY_POS_WRITE |
+				     KEY_POS_LINK | KEY_POS_SETATTR |
+				     KEY_USR_SEARCH | KEY_USR_VIEW |
+				     KEY_USR_READ;
+		int digest_b64_len;
+
+		/* Convert raw digest to base64 string for identity */
+		digest_b64 = kmalloc(BASE64_CHARS(psk->digest_len) + 1, GFP_KERNEL);
+		if (!digest_b64)
+			continue;
+
+		digest_b64_len = base64_encode(psk->digest, psk->digest_len,
+					       digest_b64, false, BASE64_STD);
+		digest_b64[digest_b64_len] = '\0';
+
+		/* Build identity: "NVMe<v>R<hh> <hostnqn> <subnqn> <digest>" */
+		identity = kasprintf(GFP_KERNEL, "NVMe%uR%02u %s %s %s",
+				     psk->version, psk->hmac, hostnqn,
+				     subnqn, digest_b64);
+		if (!identity) {
+			kfree(digest_b64);
+			continue;
+		}
+
+		/* Create PSK key in target keyring */
+		keyref = key_create_or_update(make_key_ref(keyring, true),
+					"psk", identity, psk->key_data,
+					psk->key_len, keyperm,
+					KEY_ALLOC_NOT_IN_QUOTA |
+					KEY_ALLOC_BUILT_IN |
+					KEY_ALLOC_BYPASS_RESTRICTION);
+
+		if (!IS_ERR(keyref)) {
+			key = key_ref_to_ptr(keyref);
+			pr_debug("created PSK %x '%s' in keyring %x\n",
+				 key->serial, identity, keyring_id);
+			if (first_psk_serial == 0)
+				first_psk_serial = key->serial;
+			key_put(key);
+		} else {
+			pr_debug("failed to create PSK '%s': %ld\n",
+				 identity, PTR_ERR(keyref));
+		}
+
+		kfree(digest_b64);
+		kfree(identity);
+	}
+
+	up_read(&req_key->sem);
+
+	if (first_psk_serial)
+		pr_debug("obtained %d PSK(s) via upcall, first: %08x\n",
+			 payload->psk_count, first_psk_serial);
+	else
+		pr_debug("PSK upcall returned no valid PSKs\n");
+
+out_put_req:
+	key_put(req_key);
+out_free:
+	kfree(callout_info);
+	kfree(description);
+	return first_psk_serial;
+}
+
 /**
  * nvme_tls_psk_refresh - Refresh TLS PSK
  * @keyring: Keyring holding the TLS PSK
@@ -235,6 +590,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 	key_serial_t tls_key_id;
 	int prio;
 
+	/* First, search the keyring for existing PSKs (fast path) */
 	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
 		bool generated = nvme_tls_psk_prio[prio].generated;
 		u8 ver = nvme_tls_psk_prio[prio].psk_ver;
@@ -248,6 +604,12 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 			return tls_key_id;
 		}
 	}
+
+	/* If not found in keyring, try userspace upcall (slow path) */
+	tls_key_id = nvme_tls_psk_request(keyring, hostnqn, subnqn);
+	if (tls_key_id)
+		return tls_key_id;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
@@ -270,11 +632,20 @@ static int __init nvme_keyring_init(void)
 		key_put(nvme_keyring);
 		return err;
 	}
+
+	err = register_key_type(&nvme_tls_psk_request_key_type);
+	if (err) {
+		unregister_key_type(&nvme_tls_psk_key_type);
+		key_put(nvme_keyring);
+		return err;
+	}
+
 	return 0;
 }
 
 static void __exit nvme_keyring_exit(void)
 {
+	unregister_key_type(&nvme_tls_psk_request_key_type);
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
-- 
2.53.0


