Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1881BF46449
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 10:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zcvaKNfO4uQUcaiKIyMWo3C9FaujvwWJSinZ9F2drX0=; b=wX64miQKlmtYNigb2L3aaDrFpj
	ksppb/YkGkQwXw+eUXR0gT7JKwTF99gAHEyW28NLEE8hsKrjr3gkDLRynpSvfBWeL5s74qoGEH8LA
	Nqn6f3Cg6TcehicM9r/sfPoUrFie3fN3mosfZ4V2MhWwlOvzW/MAOMzC2yIRhYBeeXH95CJvTphWi
	m0QZu9Zn5beifYecxPYOzJcTI9X9pa74Mcf/sfNP85JJ9x72SgVslnqYSFQhJtzUf3pe7YcHHn35m
	8tucwpIYf0mRMUcETXeqvP+MFheVgjW7Q8QNLy1Dm49glwiSoJ++0RVtn69k/rq8Vq33mbxsgVz7L
	ibCbT5sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w25AP-00000003kcb-3Ekw;
	Mon, 16 Mar 2026 10:27:21 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w25AN-00000003kc2-049Y
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 10:27:21 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5D544D22A;
	Mon, 16 Mar 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773656835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcvaKNfO4uQUcaiKIyMWo3C9FaujvwWJSinZ9F2drX0=;
	b=AzqjCKTBcvvDDUaMogZ07+6Ncg3aFr6YEKCJdETS7k5pffqof4LMyM9HwN+gDqhWSRfuvt
	VzVTrtjPNmXZ6zMhbLZ5bNKVVA+oZ8L3tIwA3s5vSVy57jir0CkXHReBAmabeH6c7AkOuR
	K9EWyfjhT23W1jAknxfUAm2G58PhbTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773656835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcvaKNfO4uQUcaiKIyMWo3C9FaujvwWJSinZ9F2drX0=;
	b=3su6X3IoHM2627uO1WFO3ddGATpzHiyYt17E6xQ1HrVzO6uryIQbvALet6A74thCY/M3a3
	kWjRWbwiVQx5dZDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AzqjCKTB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3su6X3Io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773656835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcvaKNfO4uQUcaiKIyMWo3C9FaujvwWJSinZ9F2drX0=;
	b=AzqjCKTBcvvDDUaMogZ07+6Ncg3aFr6YEKCJdETS7k5pffqof4LMyM9HwN+gDqhWSRfuvt
	VzVTrtjPNmXZ6zMhbLZ5bNKVVA+oZ8L3tIwA3s5vSVy57jir0CkXHReBAmabeH6c7AkOuR
	K9EWyfjhT23W1jAknxfUAm2G58PhbTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773656835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zcvaKNfO4uQUcaiKIyMWo3C9FaujvwWJSinZ9F2drX0=;
	b=3su6X3IoHM2627uO1WFO3ddGATpzHiyYt17E6xQ1HrVzO6uryIQbvALet6A74thCY/M3a3
	kWjRWbwiVQx5dZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A62F94273B;
	Mon, 16 Mar 2026 10:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GV5gJwPbt2n8WwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 16 Mar 2026 10:27:15 +0000
Date: Mon, 16 Mar 2026 11:27:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: libnvme API review
Message-ID: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.68 / 50.00];
	BAYES_HAM(-2.17)[96.03%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:32098, ipnet:2800::/6, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: B5D544D22A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_032719_893193_05E05CCA 
X-CRM114-Status: UNSURE (   9.40  )
X-CRM114-Notice: Please train this message.
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

Hi,

For the upcoming v3.0 release of nvme-cli and libnvme, I would like to
get some feedback on the naming scheme used in the libnvme function API.

The goal is to improve consistency across the library. Below is a table
comparing the current names with the suggested new names.

Functions are grouped by common prefixes:

- Generic top-level functions use the nvme_ prefix.
- Object-specific functions use the object type as a
  prefix (e.g., nvme_ns_).

The prefix is typically followed by a verb, such as nvme_create_ctrl.

WDYT?

Thanks,
Daniel

https://github.com/igaw/nvme-cli/blob/api/libnvme/doc/function-index.md

## tree.h — libnvme tree object interface

| Function                             | Suggested Name           |
|--------------------------------------|--------------------------|
| `nvme_create_ctrl`                   |                          |
| `nvme_ctrl_config_match`             | `nvme_ctrl_match_config` |
| `nvme_ctrl_first_ns`                 |                          |
| `nvme_ctrl_first_path`               |                          |
| `nvme_ctrl_for_each_ns_safe`         |                          |
| `nvme_ctrl_for_each_ns`              |                          |
| `nvme_ctrl_for_each_path_safe`       |                          |
| `nvme_ctrl_for_each_path`            |                          |
| `nvme_ctrl_get_address`              |                          |
| `nvme_ctrl_get_config`               |                          |
| `nvme_ctrl_get_dhchap_host_key`      |                          |
| `nvme_ctrl_get_phy_slot`             |                          |
| `nvme_ctrl_get_src_addr`             |                          |
| `nvme_ctrl_get_state`                |                          |
| `nvme_ctrl_get_subsysnqn`            |                          |
| `nvme_ctrl_get_subsystem`            |                          |
| `nvme_ctrl_get_transport_handle`     |                          |
| `nvme_ctrl_identify`                 | `nvme_identify_ctrl`     |
| `nvme_ctrl_is_discovered`            |                          |
| `nvme_ctrl_is_discovery_ctrl`        |                          |
| `nvme_ctrl_is_persistent`            |                          |
| `nvme_ctrl_is_unique_discovery_ctrl` |                          |
| `nvme_ctrl_next_ns`                  |                          |
| `nvme_ctrl_next_path`                |                          |
| `nvme_ctrl_release_transport_handle` |                          |
| `nvme_ctrl_set_dhchap_host_key`      |                          |
| `nvme_disconnect_ctrl`               |                          |
| `nvme_dump_config`                   |                          |
| `nvme_dump_tree`                     |                          |
| `nvme_first_host`                    |                          |
| `nvme_first_subsystem`               |                          |
| `nvme_for_each_host_safe`            |                          |
| `nvme_for_each_host`                 |                          |
| `nvme_for_each_subsystem_safe`       |                          |
| `nvme_for_each_subsystem`            |                          |
| `nvme_free_ctrl`                     |                          |
| `nvme_free_host`                     |                          |
| `nvme_free_ns`                       |                          |
| `nvme_free_subsystem`                |                          |
| `nvme_get_application`               |                          |
| `nvme_get_attr`                      |                          |
| `nvme_get_ctrl_attr`                 |                          |
| `nvme_get_ns_attr`                   |                          |
| `nvme_get_path_attr`                 |                          |
| `nvme_get_subsys_attr`               |                          |
| `nvme_host_get_global_ctx`           |                          |
| `nvme_host_get_ids`                  |                          |
| `nvme_host_get`                      | `nvme_get_host`          |
| `nvme_host_is_pdc_enabled`           |                          |
| `nvme_host_release_fds`              |                          |
| `nvme_host_set_pdc_enabled`          |                          |
| `nvme_init_ctrl`                     |                          |
| `nvme_namespace_first_path`          |                          |
| `nvme_namespace_for_each_path_safe`  |                          |
| `nvme_namespace_for_each_path`       |                          |
| `nvme_namespace_next_path`           |                          |
| `nvme_next_host`                     |                          |
| `nvme_next_subsystem`                |                          |
| `nvme_ns_compare`                    |                          |
| `nvme_ns_flush`                      |                          |
| `nvme_ns_get_csi`                    |                          |
| `nvme_ns_get_ctrl`                   |                          |
| `nvme_ns_get_eui64`                  |                          |
| `nvme_ns_get_firmware`               |                          |
| `nvme_ns_get_generic_name`           |                          |
| `nvme_ns_get_model`                  |                          |
| `nvme_ns_get_nguid`                  |                          |
| `nvme_ns_get_serial`                 |                          |
| `nvme_ns_get_subsystem`              |                          |
| `nvme_ns_get_uuid`                   |                          |
| `nvme_ns_head_get_sysfs_dir`         |                          |
| `nvme_ns_identify_descs`             |                          |
| `nvme_ns_identify`                   |                          |
| `nvme_ns_read`                       |                          |
| `nvme_ns_verify`                     |                          |
| `nvme_ns_write_uncorrectable`        |                          |
| `nvme_ns_write_zeros`                |                          |
| `nvme_ns_write`                      |                          |
| `nvme_path_get_ctrl`                 |                          |
| `nvme_path_get_ns`                   |                          |
| `nvme_path_get_queue_depth`          |                          |
| `nvme_read_config`                   |                          |
| `nvme_refresh_topology`              |                          |
| `nvme_release_fds`                   |                          |
| `nvme_rescan_ctrl`                   |                          |
| `nvme_scan_ctrl`                     |                          |
| `nvme_scan_namespace`                |                          |
| `nvme_scan_topology`                 |                          |
| `nvme_set_application`               |                          |
| `nvme_skip_namespaces`               |                          |
| `nvme_subsystem_first_ctrl`          |                          |
| `nvme_subsystem_first_ns`            |                          |
| `nvme_subsystem_for_each_ctrl_safe`  |                          |
| `nvme_subsystem_for_each_ctrl`       |                          |
| `nvme_subsystem_for_each_ns_safe`    |
| `nvme_subsystem_for_each_ns`         |                          |
| `nvme_subsystem_get_fw_rev`          |                          |
| `nvme_subsystem_get_host`            |                          |
| `nvme_subsystem_get_nqn`             |                          |
| `nvme_subsystem_get_type`            |                          |
| `nvme_subsystem_get`                 | `nvme_get_subsystem`     |
| `nvme_subsystem_lookup_namespace`    |                          |
| `nvme_subsystem_next_ctrl`           |                          |
| `nvme_subsystem_next_ns`             |                          |
| `nvme_subsystem_release_fds`         |                          |
| `nvme_unlink_ctrl`                   |                          |
---

## linux.h — Linux-specific key and identity utilities

| Function                                | Suggested Name                      |
|-----------------------------------------|-------------------------------------|
| `nvme_describe_key_serial`              |                                     |
| `nvme_export_tls_key_versioned`         |                                     |
| `nvme_export_tls_key`                   |                                     |
| `nvme_gen_dhchap_key`                   |                                     |
| `nvme_generate_tls_key_identity_compat` |                                     |
| `nvme_generate_tls_key_identity`        |                                     |
| `nvme_hostid_from_file`                 | `nvme_read_hostid`                  |
| `nvme_hostid_generate`                  | `nvme_generate_hostid`              |
| `nvme_hostnqn_from_file`                | `nvme_read_hostnqn`                 |
| `nvme_hostnqn_generate_from_hostid`     | `nvme_generate_hostnqn_from_hostid` |
| `nvme_hostnqn_generate`                 | `nvme_generate_hostnqn`             |
| `nvme_import_tls_key_versioned`         |                                     |
| `nvme_import_tls_key`                   |                                     |
| `nvme_insert_tls_key_compat`            |                                     |
| `nvme_insert_tls_key_versioned`         |                                     |
| `nvme_insert_tls_key`                   |                                     |
| `nvme_lookup_key`                       |                                     |
| `nvme_lookup_keyring`                   |                                     |
| `nvme_read_key`                         |                                     |
| `nvme_revoke_tls_key`                   |                                     |
| `nvme_scan_tls_keys`                    |                                     |
| `nvme_set_keyring`                      |                                     |
| `nvme_update_key`                       |                                     |

---

## lib.h — libnvme library context and device management

| Function                                 | Suggested Name |
|------------------------------------------|----------------|
| `nvme_close`                             |                |
| `nvme_create_global_ctx`                 |                |
| `nvme_free_global_ctx`                   |                |
| `nvme_get_logging_level`                 |                |
| `nvme_open`                              |                |
| `nvme_set_dry_run`                       |                |
| `nvme_set_ioctl_probing`                 |                |
| `nvme_set_logging_level`                 |                |
| `nvme_set_probe_enabled`                 |                |
| `nvme_transport_handle_get_fd`           |                |
| `nvme_transport_handle_get_name`         |                |
| `nvme_transport_handle_is_blkdev`        |                |
| `nvme_transport_handle_is_chardev`       |                |
| `nvme_transport_handle_is_direct`        |                |
| `nvme_transport_handle_is_mi`            |                |
| `nvme_transport_handle_set_decide_retry` |                |
| `nvme_transport_handle_set_submit_entry` |                |
| `nvme_transport_handle_set_submit_exit`  |                |

---

## ioctl.h — NVMe IOCTL passthrough interface

| Function                     | Suggested Name         |
|------------------------------|------------------------|
| `nvme_ctrl_reset`            | `nvme_reset_ctrl`      |
| `nvme_get_nsid`              |                        |
| `nvme_ns_rescan`             | `nvme_rescan_ns`       |
| `nvme_submit_admin_passthru` |                        |
| `nvme_submit_io_passthru`    |                        |
| `nvme_subsystem_reset`       | `nvme_reset_subsystem` |

---

## filters.h — libnvme directory filter

| Function                         | Suggested Name          |
|----------------------------------|-------------------------|
| `nvme_ctrls_filter`              | `nvme_filter_ctrls`     |
| `nvme_namespace_filter`          | `nvme_filter_namespace` |
| `nvme_paths_filter`              | `nvme_filter_paths`     |
| `nvme_scan_ctrl_namespace_paths` |                         |
| `nvme_scan_ctrl_namespaces`      |                         |
| `nvme_scan_ctrls`                |                         |
| `nvme_scan_ns_head_paths`        |                         |
| `nvme_scan_subsystem_namespaces` |                         |
| `nvme_scan_subsystems`           |                         |
| `nvme_subsys_filter`             | `nvme_filter_subsys`    |

---

## fabrics.h — NVMe-oF fabrics helper functions

| Function         | Suggested Name |
|------------------|----------------|
| `nvme_parse_uri` |                |

---

## nbft.h — NVM Express Boot Firmware Table (NBFT) parser

| Function         | Suggested Name   |
|------------------|------------------|
| `nvme_nbft_free` | `nvme_free_nbft` |
| `nvme_nbft_read` | `nvme_read_nbft` |

---

## util.h — libnvme utility functions

| Function                            | Suggested Name     |
|-------------------------------------|--------------------|
| `nvme_basename`                     |                    |
| `nvme_errno_to_string`              |                    |
| `nvme_get_version`                  |                    |
| `nvme_opcode_status_to_string`      |                    |
| `nvme_sanitize_ns_status_to_string` |                    |
| `nvme_status_to_errno`              |                    |
| `nvme_status_to_string`             |                    |
| `nvme_strerror`                     |                    |
| `nvme_uuid_find`                    | `nvme_find_uuid`   |
| `nvme_uuid_from_string`             |                    |
| `nvme_uuid_random`                  | `nvme_random_uuid` |
| `nvme_uuid_to_string`               |                    |

