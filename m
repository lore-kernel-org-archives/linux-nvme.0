From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 15 Oct 2018 14:17:36 -0700
Subject: [PATCH 3/3] nvme: Add test for fcloop
In-Reply-To: <20181015070130.6695-4-hare@suse.de>
References: <20181015070130.6695-1-hare@suse.de>
 <20181015070130.6695-4-hare@suse.de>
Message-ID: <20181015211736.GC23044@vader>

On Mon, Oct 15, 2018@09:01:30AM +0200, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  tests/nvme/029     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/029.out |   2 +
>  tests/nvme/rc      |  52 ++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100755 tests/nvme/029
>  create mode 100644 tests/nvme/029.out
> 
> diff --git a/tests/nvme/029 b/tests/nvme/029
> new file mode 100755
> index 0000000..f8ed9b5
> --- /dev/null
> +++ b/tests/nvme/029
> @@ -0,0 +1,123 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +# Copyright (C) 2018 Johannes Thumshirn, Hannes Reinecke, SUSE Linux GmbH
> +#
> +# Reproducer for nvme-fcloop
> +#
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="create nvme-fcloop with two ports and connect/disconnect"
> +
> +requires() {
> +	_have_module nvme-fcloop && _have_module nvmet && _have_module loop && \
> +		_have_configfs && _have_module nvme-core && \
> +		_have_module nvmet-fc
> +}
> +
> +test() {
> +	local subsys="blktests-subsystem-1"
> +	local remote_wwnn1="0x100140111111dbcc"
> +	local remote_wwpn1="0x200140111111dbcc"
> +	local remote_wwnn2="0x100140111111dbcd"
> +	local remote_wwpn2="0x200140111111dbcd"
> +	local host_wwnn1="0x100140111111dac8"
> +	local host_wwpn1="0x200140111111dac8"
> +	local host_wwnn2="0x100140111111dac9"
> +	local host_wwpn2="0x200140111111dac9"
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	modprobe nvmet-fc
> +	modprobe nvme-fcloop
> +
> +	_nvme_fcloop_add_tport ${remote_wwnn1} ${remote_wwpn1}
> +	_nvme_fcloop_add_tport ${remote_wwnn2} ${remote_wwpn2}
> +
> +	_nvme_fcloop_add_lport ${host_wwnn1} ${host_wwpn1}
> +	_nvme_fcloop_add_lport ${host_wwnn2} ${host_wwpn2}
> +
> +	_nvme_fcloop_add_rport ${host_wwnn1} ${host_wwpn1} \
> +		${remote_wwnn1} ${remote_wwpn1}
> +	_nvme_fcloop_add_rport ${host_wwnn2} ${host_wwpn2} \
> +		${remote_wwnn2} ${remote_wwpn2}
> +
> +	local port1
> +	port1=$(_create_nvmet_port "fc")
> +	ag1="$(_create_nvmet_anagroup "${port1}")"
> +
> +	local port2
> +	port2=$(_create_nvmet_port "fc")
> +	ag2="$(_create_nvmet_anagroup "${port2}")"
> +
> +	local remote_traddr1
> +	remote_traddr1=$(printf "nn-%s:pn-%s" "${remote_wwnn1}" "${remote_wwpn1}")
> +	echo fc > /sys/kernel/config/nvmet/ports/${port1}/addr_adrfam
> +	echo "${remote_traddr1}" > /sys/kernel/config/nvmet/ports/${port1}/addr_traddr
> +
> +	local remote_traddr2
> +	remote_traddr2=$(printf "nn-%s:pn-%s" "${remote_wwnn2}" "${remote_wwpn2}")
> +	echo fc > /sys/kernel/config/nvmet/ports/${port2}/addr_adrfam
> +	echo "${remote_traddr2}" > /sys/kernel/config/nvmet/ports/${port2}/addr_traddr
> +
> +	truncate -s 1G "$TMPDIR/img"
> +
> +	local loop_dev
> +	loop_dev="$(losetup -f --show "$TMPDIR/img")"
> +
> +	_create_nvmet_subsystem "${subsys}" "${loop_dev}" \
> +		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
> +	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
> +	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
> +
> +	_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
> +	_set_nvmet_anagroup_state "${port2}" "2" "optimized"
> +
> +	local host_traddr1
> +	host_traddr1=$(printf "nn-%s:pn-%s" "${host_wwnn1}" "${host_wwpn1}")
> +
> +	nvme connect -t fc -a "${remote_traddr1}"  -w "${host_traddr1}" \
> +		-n "${subsys}"
> +
> +	local host_traddr2
> +	host_traddr2=$(printf "nn-%s:pn-%s" "${host_wwnn2}" "${host_wwpn2}")
> +
> +	nvme connect -t fc -a "${remote_traddr2}"  -w "${host_traddr2}" \
> +		-n "${subsys}"
> +
> +	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"

nvmedev doesn't seem to be used anywhere (shellcheck warns about this).

> +	# Allow I/O to settle
> +	udevadm settle
> +
> +	nvme disconnect -n "${subsys}"

This outputs the following with my version (1.6) of nvme:

NQN:blktests-subsystem-1 disconnected 2 controller(s)

> +	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
> +	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
> +	_remove_nvmet_subsystem "${subsys}"
> +	_remove_nvmet_anagroup "${port1}" "${ag1}"
> +	_remove_nvmet_port "${port1}"
> +	_remove_nvmet_anagroup "${port2}" "${ag2}"
> +	_remove_nvmet_port "${port2}"
> +
> +	losetup -d "$loop_dev"
> +	rm "$TMPDIR/img"
> +
> +	_nvme_fcloop_del_rport "${host_wwnn1}" "${host_wwpn1}" \
> +		"${remote_wwnn1}" "${remote_wwpn1}"
> +	_nvme_fcloop_del_rport "${host_wwnn2}" "${host_wwpn2}" \
> +		"${remote_wwnn2}" "${remote_wwpn2}"
> +
> +	_nvme_fcloop_del_tport "${remote_wwnn1}" "${remote_wwpn1}"
> +	_nvme_fcloop_del_tport "${remote_wwnn2}" "${remote_wwpn2}"
> +
> +	_nvme_fcloop_del_lport "${host_wwnn1}" "${host_wwpn1}"
> +	_nvme_fcloop_del_lport "${host_wwnn2}" "${host_wwpn2}"
> +
> +	modprobe -r nvme-fcloop
> +	modprobe -r nvmet-fc
> +	modprobe -r nvmet
> +	modprobe -r loop

We don't want to try to remove loop, that's a generic enough module that
it might be in use elsewhere on the system.
