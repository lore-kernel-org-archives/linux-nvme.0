From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 29 Jul 2019 10:31:19 -0700
Subject: [PATCH blktests v2 00/12] Fix nvme block test issues
In-Reply-To: <20190717171259.3311-1-logang@deltatee.com>
References: <20190717171259.3311-1-logang@deltatee.com>
Message-ID: <20190729173119.GA30186@vader>

On Wed, Jul 17, 2019@11:12:47AM -0600, Logan Gunthorpe wrote:
> Changes since v1:
>  * Use second sed expression instead of another call to grep
>    in _filter_discovery() for Patch 2 (per Omar)
>  * Redirect error output to $FULL in for nvme/018 in Patch 7
>    (Per Johannes)
>  * Rework _have_module_param() in Patch 11 so that it supports
>    cases where the module is not inserted.
> 
> --
> 
> This patchset cleans up a number of issues and pain points
> I've had with getting the nvme blktests to pass and run cleanly.
> 
> The first three patches are meant to fix the Generation Counter
> issue that's been discussed before but hasn't been fixed in months.
> I primarily use a slightly fixed up patch posted by Michael Moese[1]
> but add another patch to properly test the Generation Counter that
> would no longer be tested otherwise.
> 
> I've also taken it a step further to filter out more of the discovery
> information so that we are less fragile against churn and less dependant
> on the version of nvme-cli in use. This should also fix the issue discussed
> in [2].
> 
> Patches 4 through 7 fix a number of smaller issues I've found with
> individual tests.
> 
> Patches 8 through 10 implement a system to ensure the nvme tests
> clean themselves up properly especially when ctrl-c is used to
> interrupt a test (working with the tests before this was a huge
> pain seeing,  when you ctrl-c, you have to either manually clean
> up the nvmet configuration or reboot to get the system in a state
> where it's sane to run the tests again).
> 
> Patches 11 and 12 make some minor changes that allow running the
> tests with the nvme modules built into the kernel.
> 
> With these patches, plus a couple I've sent to the nvme list for the
> kernel, I can consistently pass the entire nvme suite with the
> exception of the lockdep false-positive with nvme/012 that still
> seems to be in a bit of contention[3].
> 
> [1] https://github.com/osandov/blktests/pull/34
> [2] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev at gmail.com/
> [3] https://lore.kernel.org/lkml/20190214230058.196511-22-bvanassche at acm.org/

Merged, thanks, Logan!
