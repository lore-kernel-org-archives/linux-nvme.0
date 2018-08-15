From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 03:31:20 +0000
Subject: [PATCH 2/2] blktests: add test for ANA state transition
In-Reply-To: <20180814215624.GB10954@vader>
References: <20180802103455.82148-1-hare@suse.de>
 <20180802103455.82148-3-hare@suse.de> <20180814215624.GB10954@vader>
Message-ID: <66CC8A1A-21A9-4ADB-AB80-4F63371511C7@wdc.com>

One way to avoid this is if a testcase is validating optional commands or controller feature then
it should execute id-ctrl or id-ns, based on the output check for the appropriate bits
before proceeding.


On 8/14/18, 2:56 PM, "Omar Sandoval" <osandov@osandov.com> wrote:

    On Thu, Aug 02, 2018@12:34:55PM +0200, Hannes Reinecke wrote:
    > Add a simple test for ANA state transition handling.
    > 
    > Signed-off-by: Hannes Reinecke <hare at suse.com>
    > ---
    >  tests/nvme/018     | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
    >  tests/nvme/018.out |  18 +++++++
    >  2 files changed, 171 insertions(+)
    >  create mode 100755 tests/nvme/018
    >  create mode 100644 tests/nvme/018.out
    > 
    > diff --git a/tests/nvme/018 b/tests/nvme/018
    > new file mode 100755
    > index 0000000..b7f9e00
    > --- /dev/null
    > +++ b/tests/nvme/018
    > @@ -0,0 +1,153 @@
    > +#!/bin/bash
    > +#
    > +# Regression test for ANA base support
    > +#
    > +# Copyright (C) 2018 Hannes Reinecke
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
    > +. tests/nvme/rc
    > +
    > +DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
    > +QUICK=1
    > +
    > +switch_nvmet_anagroup() {
    > +	local port1="$1"
    > +	local port2="$2"
    > +	local mode="$3"
    > +
    > +	echo "ANA state ${mode}"
    > +
    > +	if [ "${mode}" = "change" ] ; then
    > +		_set_nvmet_anagroup_state "${port1}" "1" "change"
    > +		_set_nvmet_anagroup_state "${port1}" "2" "change"
    > +		_set_nvmet_anagroup_state "${port2}" "1" "change"
    > +		_set_nvmet_anagroup_state "${port2}" "2" "change"
    > +	elif [ "${mode}" = "failover" ] ; then
    > +		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
    > +		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
    > +		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
    > +		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
    > +	else
    > +		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
    > +		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
    > +		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
    > +		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
    > +	fi
    > +}
    > +
    > +requires() {
    > +	_have_program nvme && _have_module nvme-loop && _have_module loop && \
    > +		_have_configfs && _have_fio
    
    Sorry for the delay. This needs _have_program mkfs.xfs. Is there any way
    to detect if the kernel supports ANA? This fails miserably on 4.18,
    obviously.
    
    Thanks!
    
