From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 14 May 2018 13:10:58 -0700
Subject: [PATCH blktests] nvme: Add command timeout injection test
In-Reply-To: <20180514200237.15135-1-keith.busch@intel.com>
References: <20180514200237.15135-1-keith.busch@intel.com>
Message-ID: <20180514201058.GC13417@vader>

On Mon, May 14, 2018@02:02:37PM -0600, Keith Busch wrote:
> This test will run a background IO process and inject an admin command
> with a very short timeout that is all but guaranteed to expire without
> a completion: the async event request.

Thanks, a few comments below.

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  tests/nvme/005     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/005.out |  3 +++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/005
>  create mode 100644 tests/nvme/005.out
> 
> diff --git a/tests/nvme/005 b/tests/nvme/005
> new file mode 100755
> index 0000000..3fe9cbe
> --- /dev/null
> +++ b/tests/nvme/005
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +#
> +# Regression test for timeout handling.

Is there a specific patch that this is testing? If so, could you add:

Regression test for patch "so and so".

> +# Copyright (C) 2018 Keith Busch
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
> +DESCRIPTION="test nvme admin command timeout handling with in-flight io"
> +
> +QUICK=1
> +
> +requires() {
> +	_have_program nvme

Also needs && _have_fio.

> +}
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# start fio job
> +	_run_fio_rand_io --filename="${TEST_DEV}" --time_based --runtime=20 &
> +
> +	sleep 5
> +
> +	# send nvme admin command 'async event request', which  will surely time out
> +	nvme admin-passthru ${TEST_DEV} -o 0xc --timeout=1

Missing quotes around ${TEST_DEV}.

> +	wait
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/005.out b/tests/nvme/005.out
> new file mode 100644
> index 0000000..f4ff837
> --- /dev/null
> +++ b/tests/nvme/005.out
> @@ -0,0 +1,3 @@
> +Running nvme/005
> +passthru: Interrupted system call
> +Test complete
> -- 
> 2.14.3
> 
