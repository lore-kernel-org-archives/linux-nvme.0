Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAB4C48BC4
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xVhgNarxlIIrhgQz3bItMJFCwPCCkfl7pWsey5y6Gos=; b=b6U/KTNj+zf4UCs5t5C02o0/fq
	ZrBbG6ik8xCAR56Jg4TCCe4VA7Hh8fS9m2rmEAO/LkrzV/6czbvJJJYlFUVOKw++6X9PndJUEkvXX
	oRxre7LWtlsOLg3KG2YtsebAXRcng4sAYfUO507PgBIIiBC+KHKpcfFf2HPtVUquXjJX8ji5qvLcD
	zGQpPR446eg8IaQM8tux8eaNfrFgNsfE2cSlbgSuOQNY7wIdHISVCNQ90bX5NMEU5u/oXq5IASzOH
	/H2USVJHY9I0qhEX5Vg5OmdOeRURgiShr8TlNSPPQwu1g3/kwX2OhJP8T3cSA2iaVhK/uTAQWFthB
	gccotuRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raC9W-0000000CTOd-2Rzg;
	Wed, 14 Feb 2024 10:06:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raC9S-0000000CTNl-3MO3
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 10:06:05 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D35921FE1
	for <linux-nvme@lists.infradead.org>; Wed, 14 Feb 2024 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707905159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xVhgNarxlIIrhgQz3bItMJFCwPCCkfl7pWsey5y6Gos=;
	b=lOUpLbue6YAN6yIg6gDSfn7Wdq/wIqHrJjB/c97mlLPDHsr0/2/0RQaA5TJjX/5x1RD9qe
	5Z3yqtwTwn4ppVdqThaCNVC0V19RtPPuca7aBZ1WzQYUJtY89T/471Xq7i4NcBR9pDIKjV
	6mEYlMlBb9+jsq2rRHzCov8+QG/jrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707905159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xVhgNarxlIIrhgQz3bItMJFCwPCCkfl7pWsey5y6Gos=;
	b=6EaVBR2fVVeulmXp4bATPznM6Vn6GlP4Z+xPzHHtuxuKamCuXbIFyuahD9IaVlvipP0TW3
	Jv4fGL9GYgn0+hAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707905159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xVhgNarxlIIrhgQz3bItMJFCwPCCkfl7pWsey5y6Gos=;
	b=lOUpLbue6YAN6yIg6gDSfn7Wdq/wIqHrJjB/c97mlLPDHsr0/2/0RQaA5TJjX/5x1RD9qe
	5Z3yqtwTwn4ppVdqThaCNVC0V19RtPPuca7aBZ1WzQYUJtY89T/471Xq7i4NcBR9pDIKjV
	6mEYlMlBb9+jsq2rRHzCov8+QG/jrJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707905159;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xVhgNarxlIIrhgQz3bItMJFCwPCCkfl7pWsey5y6Gos=;
	b=6EaVBR2fVVeulmXp4bATPznM6Vn6GlP4Z+xPzHHtuxuKamCuXbIFyuahD9IaVlvipP0TW3
	Jv4fGL9GYgn0+hAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC1C213A1A
	for <linux-nvme@lists.infradead.org>; Wed, 14 Feb 2024 10:05:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CPBBOIaQzGVLUAAAn2gu4w
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Wed, 14 Feb 2024 10:05:58 +0000
Date: Wed, 14 Feb 2024 11:05:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: libnvme v1.8 and nvme-cli v2.8 release
Message-ID: <dr76ik5h5u6edzvsqi5vttmf6nqrtkrvtdve3z2mlncjqzybsr@zibw5t3reaaa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_020603_023321_AAA029F7 
X-CRM114-Status: GOOD (  12.71  )
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

** libnvme v1.8

It's not a very interesting release this time. There are mostly small bug fixes and a few improvements in the testing area. Though it's worth to get these fixes out.

Thanks to all: Hannes Reinecke, Jian Zhang, Jinliang Wang, Leonardo da Cunha, Martin George, Martin Wilck, Tokunori Ikegami, Tomas Bzatek

Daniel Wagner (12):
      build: fix release python tag match
      build: checkout full repo for checkpatch
      json-schema: add keyring and tls_key details
      tree: use logical block size for lba
      libnvme: export nvme_dump_tree
      json: dump the output to the user selected filedescriptor
      nvme: allow to overwrite base sysfs path
      nvme: allow to overwrite hostnqn and hostid
      test: read and dump sysfs tar file
      tree: do not issue an error when subsys lookup fails during scanning
      build: Update version to v1.8
      doc: Regenerate all docs for v1.8

Hannes Reinecke (3):
      meson.build: fixup 'join' syntax
      Merge pull request #770 from hreinecke/fix-join.v2
      fabrics: add 'concat' option

Jian Zhang (1):
      example: fix mi identify failed with error cntid

Jinliang Wang (1):
      mi: set correct rc and errno when crc mismatch

Leonardo da Cunha (1):
      util: Added function to find specific UUID in UUID list.

Martin George (1):
      linux: avoid segfault in check-tls-key due to null hostnqn/subsysnqn

Martin Wilck (1):
      nbft: avoid duplicate entries in ssns->hfis

Tokunori Ikegami (1):
      types: Add controller properties CMBEBS, CMBSWTP and NSSD

Tomas Bzatek (9):
      fabrics: Explicitly initialize auto-cleanup variables
      linux: Explicitly initialize auto-cleanup variables
      tree: Explicitly initialize auto-cleanup variables
      util: Explicitly initialize auto-cleanup variables
      nbft: Fix (struct nbft_info_subsystem_ns).num_hfis off-by-one
      tests: Fix diffs output for duplicate HFI entries
      tests: Add sample NBFT table from Dell PowerEdge R760
      tests: Add sample NBFT table from Dell PowerEdge R660
      linux: Explicitly initialize auto-cleanup variables

dependabot[bot] (1):
      build(deps): bump codecov/codecov-action from 3 to 4

** nvme-cli v2.8

The sedcli project for doing SED Opal operation has been archived and the only maintained fork is a private project. Thus Greg has implemented some basic commands as a new plugin.

The rest is mostly bug fixes. So nothing to exciting but still worth to get released.

Thanks to all: Anant Mashiana, Bean Li, Caleb Sander, Felix Yan, Greg Joyce, Hannes Reinecke, Keith Busch, Leonardo da Cunha, Martin George, Maurizio Lombardi, Minsik Jeon, Stuart Hayes, jeff-lien-wdc

Anant Mashiana (1):
      completions: added Solidigm plugin to autocomplete scripts

Bean Li (1):
      nvme: do not include meta data for PRACT=1 and MD=8 (version 2)

Caleb Sander (1):
      nvme: Remove unused cfg argument from NVME_ARGS() macro

Daniel Wagner (6):
      nbft: fixup include for libnvme
      nbft: do not issue an error if ACPI tables are missing
      nvme-print-json: append array object in json_support_log
      build: bump libnvme version
      build: Update version to v2.8
      doc: Regenerate all docs for v2.8

Felix Yan (2):
      doc: Fix short option name for cfg-file
      doc: Fix config-schema.json's URL

Greg Joyce (1):
      sed: Add plugin for basic SED Opal operations

Hannes Reinecke (3):
      Merge pull request #2165 from martin-gpy/warnings_verbose_level
      build: Update libnvme wrap
      nvme-fabrics: enable option 'concat'

Keith Busch (2):
      nvme: fix directive receive identify offsets
      don't include newlines in already wrapped text

Leonardo da Cunha (1):
      plugins/solidigm: Compressing vs-internal-log log files into zip file.

Martin George (3):
      fabrics: move hostid/hostnqn warnings to verbose level
      nvme: print inserted tls key for check-tls-key
      nvme-print: fix typo in list verbose output

Maurizio Lombardi (1):
      create-ns: align the namespaces to 1Mib boundaries when using SI suffixes

Minsik Jeon (1):
      nvme: use correct telemetry log size

Stuart Hayes (1):
      nbft: fix tcp/dhcp address fallback retry

dependabot[bot] (1):
      build(deps): bump codecov/codecov-action from 3 to 4

jeff-lien-wdc (2):
      plugins/wdc: Plugin fixes and updates
      plugins/wdc: Add Debug Log Collection Support

