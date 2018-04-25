From: osandov@osandov.com (Omar Sandoval)
Date: Wed, 25 Apr 2018 08:30:36 -0700
Subject: [PATCH blktests 3/3] nvme: add a regression test for UUID ns
 descriptops
In-Reply-To: <20180424161251.6502-3-jthumshirn@suse.de>
References: <20180424161251.6502-1-jthumshirn@suse.de>
 <20180424161251.6502-3-jthumshirn@suse.de>
Message-ID: <20180425153036.GA30070@vader>

On Tue, Apr 24, 2018@10:12:51AM -0600, Johannes Thumshirn wrote:
> Add a regression test for NVMe 1.3's UUID Namespace Descriptors.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks, Johannes, applied. A couple of comments below for future
reference.

> ---
>  tests/nvme/004     | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/004.out |  4 +++
>  2 files changed, 78 insertions(+)
>  create mode 100755 tests/nvme/004
>  create mode 100644 tests/nvme/004.out
> 
> diff --git a/tests/nvme/004 b/tests/nvme/004
> new file mode 100755
> index 000000000000..cc1c3fd41b25
> --- /dev/null
> +++ b/tests/nvme/004
> @@ -0,0 +1,74 @@
> +#!/bin/bash
> +#
> +# Regression test for commits d934f9848a77 ("nvme: provide UUID value to
> +# userspace") and 6484f5d16f9d ("nvme: also provide a UUID in the WWID sysfs
> +# attribute")
> +#
> +# Copyright (C) 2018 Johannes Thumshirn
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 3 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +# TODO: fill in a very brief description of what this test does. The
> +# description should complete the sentence "This test will...". For example,
> +# "run a mixed read/write workload" would be a good description.

The TODO comment was leftover here, I removed it.

> +DESCRIPTION="Test nvme and nvmet UUID NS descriptors"
> +
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme && _have_module nvme-loop && _have_module loop \
> +	    && _have_configfs
> +}
> +
> +_find_nvme_loop_dev() {
> +	for dev in /sys/block/nvme*; do
> +		dev="$(basename $dev)"

There's some missing quoting around "$dev" here. There's also some more
missing quoting, `make shellcheck` will catch this sort of thing.
