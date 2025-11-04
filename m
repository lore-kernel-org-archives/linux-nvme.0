Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3474CCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 08:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5yPPom5EQkKpKnENEVWAiI55FVm2YuKTD0Zs1aq5/h8=; b=GsG8H7+6qGTE/2C7p7fIuCwAkJ
	yIfQf/xEyojbi3jP403q7pB0efxnVTWQM1zEdZBMh8zYO3bzQSP/kUq5vLNLexXpo8ycZnMzh94/s
	bYE6wQo35raCbSNV7efL32BgdDr+4TANx9Fc241PuJp6VIxskArIN4+LqQl/SQmpUDWFnJTOqw+H+
	gFHRDlFwLMFr1ky3OxYeJs2FEns1o6fUC4nkB0cOtAVxS+++5I6c/MoMqGHOm/rBJLgb1MlxsocFX
	03WEiabiBXwy8E214xTn5tox+iTJRgMOwx/MEY5NPA4wQNjXeO3kTdvNGgi2eMA2czxqitAycX85B
	bGu853ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCBe-0000000BOkE-14nG;
	Tue, 04 Nov 2025 08:14:42 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCBc-0000000BOjh-1Cqe
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:14:41 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-28a5b8b12a1so55453525ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 00:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762244079; x=1762848879; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yPPom5EQkKpKnENEVWAiI55FVm2YuKTD0Zs1aq5/h8=;
        b=mebFRBsvWPeGF1Jn8do9S9g+dbZQE4OBGhT9eTE//BalRHBERu6+LxNAb791YSNCrB
         /rtLIA/IHFoyc+ID7u6LUA1qkDyX2iOiRc1waArgcPDm4FGmDU74yjtSTXb1JmiF0h8Y
         VLz/VmfgGVXMsEBLgIG1WFIZYbTxi9LNd23FQSj0Qs6LWF97jYhhPWNrEQINIjYatXYX
         anRUDbZhD+HQznJEmyJasBY1mCu0yHqMDwEYc55tVIUYWsKH6FggQ4nyDCXYkfNH8uSE
         X+RK08JL3DI1SewwwKmn6uHzeU2P1yu6DjU6icNQmlpPGSFPRQKMle+Xxs/nh8K4AEmc
         KT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244079; x=1762848879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yPPom5EQkKpKnENEVWAiI55FVm2YuKTD0Zs1aq5/h8=;
        b=YP6bbHeYPIZf1NJj5rzQUk5crYHiVDzabmwxZUMcyAGF75qphv2lRVC5+wMxEJ7rLa
         Gk1ThivFrSTRdKTSn/vC9gmwQuE3FsDIEHpvWtJ4TpcJvRlaFbxoVq9xKn3BQsL9l/dt
         3+e43TuI3M5ktyW6TA7cqqsM0mG9rFkIi7xSs40CHneFKl4hNGO0PUfUmv1BUhXwDvku
         osATExErC3RLCZqSo/CO+y2V/axRmRiWxfWePqwDqAia5z+hMbbwSZyMI/R7SZlGq158
         FEka+Cwqit6mZ9kCPCiDebzjqZvYlxCqv5pAOMo0acpWuYzVjNgJfwrSqSqNXHaAj7Wr
         l0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1x7/B9/7anAdlEYjpFo8gZdsJkj2MtZUtgRn5XN8haQe16qwHn0pziVQscFoFaHeOm4hVVCNWRJPE@lists.infradead.org
X-Gm-Message-State: AOJu0Yz3jf9BbwumhuDWR6tFRw13upBvdOj5XxN4o2WhbhYvt4qnmDn1
	GzDRQotKufQYcnyW8EqzbwBLB98dNaVmlPkxyE2AqcQQFakUvg0Sc6Px
X-Gm-Gg: ASbGnct+N2E+ACFi6I0bj6Vm5lXHtav4wSzMMFZZArcJY2ftZSS6r3ikon937vRJxMF
	UO0TDY8tjLopYYXM8jjn80L1RjtUE1ZxTej2etoZG2gnTD+ze09Ex0I9nJU5B+WIxa/+YZjWid1
	9HswH3qOAQSJij8MLd4Rg2UAQealXZ3mCur0wquLUCsD9rXz0ob1fiQGCzd0metWzlKsqw+cD1e
	GXXw4uPsofi5c4x2jeeOidxoDNvVTTrAfXwB5XINdTS67t6KQL6nDrpNCzSvtqvFlIksra4B+Ju
	KL23F7W5mDU6q05FFW0f/FqyF1wvulNcYBlU9tDa0QzuR4vYwLr3MC4rkp0EUKOqhYAufYBDHAu
	zdsDz/tGCoUelV9dclV5kyQT7LACa0l3hDFmcGgJ7TfjmEeIKC6B7sAfiGzsZKJ/RaHlwx694wJ
	uSI4fj8iOAixAkAjGGFiNACE4wLkJrunSRFp7B
X-Google-Smtp-Source: AGHT+IFOdB7IzjwFPem2ggmTDmjy3G6bzYqa3MERE3FT9sIp/UxQCFfmCHoNZ7seosLifsrFBq+xAQ==
X-Received: by 2002:a17:902:d48b:b0:295:fac:7b72 with SMTP id d9443c01a7336-2951a4b3595mr182681015ad.52.1762244079082;
        Tue, 04 Nov 2025 00:14:39 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601b8f28esm17214615ad.5.2025.11.04.00.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:14:38 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH blktest] blktests: add nvmet memory backend support
Date: Tue,  4 Nov 2025 00:14:36 -0800
Message-Id: <20251104081436.191823-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_001440_336947_ED6EA6C9 
X-CRM114-Status: GOOD (  15.85  )
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

Add support for testing nvmet memory backend across all transport
types. This allows tests using _set_combined_conditions with
_set_nvmet_blkdev_type to automatically test memory backend alongside
device and file backends.

The memory backend provides RAM-based volatile storage for NVMe
namespaces, useful for high-performance testing without disk I/O.

- Add "mem" to NVMET_BLKDEV_TYPES default value
- Add _require_nvme_mem_backend() prerequisite check
- Add _create_nvmet_ns_mem() helper for memory namespace creation
- Modify _nvmet_target_setup() to handle memory backend type

All existing tests that support multiple backends (device, file) will
now automatically run with memory backend as well, providing 3x test
coverage: device, file, and mem backends across loop, tcp, and rdma
transports.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 common/nvme | 135 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 125 insertions(+), 10 deletions(-)

diff --git a/common/nvme b/common/nvme
index 3d43790..a558943 100644
--- a/common/nvme
+++ b/common/nvme
@@ -23,7 +23,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
-NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file mem"}
 nvme_target_control="${NVME_TARGET_CONTROL:-}"
 NVMET_CFS="/sys/kernel/config/nvmet/"
 # shellcheck disable=SC2034
@@ -62,6 +62,35 @@ _require_nvme_trtype_is_fabrics() {
 	return 0
 }
 
+_require_nvme_mem_backend() {
+	# Check if memory backend is supported in kernel
+	local test_subsys="${NVMET_CFS}/subsystems/blktests-mem-test-$$"
+	local test_ns="${test_subsys}/namespaces/1"
+
+	if ! mkdir -p "${test_subsys}" 2>/dev/null; then
+		SKIP_REASONS+=("cannot create test subsystem in configfs")
+		return 1
+	fi
+
+	if ! mkdir -p "${test_ns}" 2>/dev/null; then
+		rmdir "${test_subsys}"
+		SKIP_REASONS+=("cannot create test namespace in configfs")
+		return 1
+	fi
+
+	# Try to set mem_size attribute
+	if ! echo "1073741824" > "${test_ns}/mem_size" 2>/dev/null; then
+		rmdir "${test_ns}"
+		rmdir "${test_subsys}"
+		SKIP_REASONS+=("nvmet memory backend not supported")
+		return 1
+	fi
+
+	rmdir "${test_ns}"
+	rmdir "${test_subsys}"
+	return 0
+}
+
 _have_nvme_cli_with_json_support() {
 	_have_program nvme || return $?
 
@@ -726,6 +755,71 @@ _create_nvmet_ns() {
 	echo "${uuid}"
 }
 
+_create_nvmet_ns_mem() {
+	local subsysnqn="${def_subsysnqn}"
+	local nsid="${def_nsid}"
+	local grpid="1"
+	local mem_size="${NVME_IMG_SIZE}"
+	local uuid
+	local subsys_path
+	local ns_path
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			--subsysnqn)
+				subsysnqn="$2"
+				shift 2
+				;;
+			--nsid)
+				nsid="$2"
+				shift 2
+				;;
+			--mem-size)
+				mem_size="$2"
+				shift 2
+				;;
+			--uuid)
+				uuid="$2"
+				shift 2
+				;;
+			--grpid)
+				grpid="$2"
+				shift 2
+				;;
+			*)
+				echo "WARNING: unknown argument: $1"
+				shift
+				;;
+		esac
+	done
+
+	subsys_path="${NVMET_CFS}/subsystems/${subsysnqn}"
+	ns_path="${subsys_path}/namespaces/${nsid}"
+
+	mkdir "${ns_path}"
+
+	# Memory backend uses mem_size instead of device_path
+	# Convert size string (e.g., "1G") to bytes
+	local mem_size_bytes
+	mem_size_bytes=$(numfmt --from=iec "${mem_size}")
+	printf "%s" "${mem_size_bytes}" > "${ns_path}/mem_size"
+
+	# Set UUID if provided, otherwise read generated one
+	if [[ -n "${uuid}" ]]; then
+		printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	else
+		uuid=$(cat "${ns_path}/device_uuid")
+	fi
+
+	# Set ANA group if not default
+	if (( grpid != 1 )); then
+		printf "%d" "${grpid}" > "${ns_path}/ana_grpid"
+	fi
+
+	printf "%d" 1 > "${ns_path}/enable"
+	echo "${uuid}"
+}
+
 _setup_nvmet_ns_ana() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
@@ -956,6 +1050,7 @@ _find_nvme_ns() {
 _nvmet_target_setup() {
 	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
+	local mem_size="${NVME_IMG_SIZE}"
 	local ctrlkey=""
 	local hostkey=""
 	local subsysnqn="${def_subsysnqn}"
@@ -1011,7 +1106,12 @@ _nvmet_target_setup() {
 		esac
 	done
 
-	if [[ "${blkdev_type}" != "none" ]]; then
+	# Handle backend-specific setup
+	if [[ "${blkdev_type}" == "mem" || "${blkdev_type}" == "memory" ]]; then
+		# Memory backend - no file or device needed
+		blkdev=""
+	elif [[ "${blkdev_type}" != "none" ]]; then
+		# Device or file backend - create backing file
 		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
 		if [[ "${blkdev_type}" == "device" ]]; then
 			blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
@@ -1036,17 +1136,32 @@ _nvmet_target_setup() {
 		return
 	fi
 
+	# Handle namespace creation based on backend type
 	ARGS=(--subsysnqn "${subsysnqn}")
-	if [[ -n "${blkdev}" ]]; then
+
+	if [[ "${blkdev_type}" == "mem" || "${blkdev_type}" == "memory" ]]; then
+		# Memory backend: create subsystem without namespace first
+		_create_nvmet_subsystem "${ARGS[@]}"
+		# Then create memory namespace separately
+		ARGS=(--subsysnqn "${subsysnqn}" --mem-size "${mem_size}")
+		if [[ -n "${subsys_uuid}" ]]; then
+			ARGS+=(--uuid "${subsys_uuid}")
+		fi
+		def_subsys_uuid=$(_create_nvmet_ns_mem "${ARGS[@]}")
+	elif [[ -n "${blkdev}" ]]; then
+		# Device or file backend: use existing flow
 		ARGS+=(--blkdev "${blkdev}")
+		if [[ -n "${subsys_uuid}" ]]; then
+			ARGS+=(--uuid "${subsys_uuid}")
+		fi
+		if [[ -n "${resv_enable}" ]]; then
+			ARGS+=("${resv_enable}")
+		fi
+		_create_nvmet_subsystem "${ARGS[@]}"
+	else
+		# No backend (none type): just create subsystem
+		_create_nvmet_subsystem "${ARGS[@]}"
 	fi
-	if [[ -n "${subsys_uuid}" ]]; then
-		ARGS+=(--uuid "${subsys_uuid}")
-	fi
-	if [[ -n "${resv_enable}" ]]; then
-		ARGS+=("${resv_enable}")
-	fi
-	_create_nvmet_subsystem "${ARGS[@]}"
 
 	p=0
 	while (( p < num_ports )); do
-- 
2.40.0


