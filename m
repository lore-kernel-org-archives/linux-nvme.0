From: stephen@networkplumber.org (Stephen Hemminger)
Date: Fri, 15 Jan 2016 10:20:52 -0800
Subject: NVM and swap device
In-Reply-To: <20160115174236.GC11165@localhost.localdomain>
References: <20160112194030.5b74ecdc@xeon-e3>
 <20160115174236.GC11165@localhost.localdomain>
Message-ID: <20160115102052.0091a976@xeon-e3>

On Fri, 15 Jan 2016 17:42:36 +0000
Keith Busch <keith.busch@intel.com> wrote:

> On Tue, Jan 12, 2016@07:40:30PM -0800, Stephen Hemminger wrote:
> > I have a nice shiny new Intel NVM PCI card; decided to use it for a filesystem and swap.
> > The filesystem (btrfs) is doing fine, but the swap device was throwing occasional
> > random errors. Suspect a driver problem rather than hardware.
> > 
> > I am using 4.4 kernel without patches.
> > 
> > kern.log:Jan 12 08:11:57 xeon-e3 kernel: [159474.037390] Read-error on swap-device (259:0:17597808)
> > kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855526] Read-error on swap-device (259:0:11355648)
> > kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87938.855530] Read-error on swap-device (259:0:11355656)
> > kern.log.1:Jan  7 08:32:10 xeon-e3 kernel: [87939.855467] Read-error on swap-device (259:0:16180824)
> > kern.log.1:Jan  8 08:24:07 xeon-e3 kernel: [63670.777981] Read-error on swap-device (259:0:32690768)
> > kern.log.1:Jan  9 09:25:02 xeon-e3 kernel: [153720.919325] Read-error on swap-device (259:0:220488)
> > kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.957675] Read-error on swap-device (259:0:24476232)
> > kern.log.1:Jan  9 16:40:05 xeon-e3 kernel: [179820.962673] Read-error on swap-device (259:0:33292816)
> > 
> > The swap device was being added via /etc/fstab by UUID. 
> 
> If you haven't any further insights into the issue, could you check the
> device's health? I'd be surprised if there is a problem with that since
> you mentioned it was new card, but would like to rule that out if this
> has hit a dead end on the other testing.
> 
> For that, we need smart logs. There are various tools available that
> can read those logs. Here's an open source version:
> 
>   https://github.com/linux-nvme/nvme-cli
> 
> Here's example output from one of my drives with the above tool:
> 
>   # nvme smart-log /dev/nvme0
>   Smart Log for NVME device:/dev/nvme0 namespace-id:ffffffff
>   critical_warning                    : 0
>   temperature                         : 29 C
>   available_spare                     : 100%
>   available_spare_threshold           : 10%
>   percentage_used                     : 0%
>   data_units_read                     : 577,600
>   data_units_written                  : 3,182,404
>   host_read_commands                  : 4,537,801
>   host_write_commands                 : 18,713,235
>   controller_busy_time                : 17
>   power_cycles                        : 1
>   power_on_hours                      : 163
>   unsafe_shutdowns                    : 1
>   media_errors                        : 0
>   num_err_log_entries                 : 0

Are these logs persistant?

# ./nvme smart-log /dev/nvme0
Smart Log for NVME device:/dev/nvme0 namespace-id:ffffffff
critical_warning                    : 0
temperature                         : 29 C
available_spare                     : 100%
available_spare_threshold           : 10%
percentage_used                     : 0%
data_units_read                     : 2,768,267
data_units_written                  : 4,085,497
host_read_commands                  : 74,458,451
host_write_commands                 : 68,420,945
controller_busy_time                : 12
power_cycles                        : 33
power_on_hours                      : 227
unsafe_shutdowns                    : 6
media_errors                        : 0
num_err_log_entries                 : 0
Critical Composite Temperature Time : 0
Temperature Sensor 1                : 0 C
Temperature Sensor 2                : 0 C
Temperature Sensor 3                : 0 C
Temperature Sensor 4                : 0 C
Temperature Sensor 5                : 0 C
Temperature Sensor 6                : 0 C
Temperature Sensor 7                : 0 C
Temperature Sensor 8                : 0 C
