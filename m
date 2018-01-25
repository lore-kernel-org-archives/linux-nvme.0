From: hare@suse.de (Hannes Reinecke)
Date: Thu, 25 Jan 2018 19:37:58 +0100
Subject: [LSF/MM TOPIC] nvme multipath parity with dm-multipath
Message-ID: <5172fd3f-ce8a-3744-4f49-bf42dc961371@suse.de>

Hi all,

Native NVMe multipathing is missing some features which are required to
achieve full parity with dm-multipath:

- Auto discovery (which already will be discussed in another topic)
- Failover handling in an all-paths-down scenario: dm-multiath goes to
  great lengths to ensure that failover _can_ happen; with nvme native
  multipathing this is only guaranteed if the reconnection timer is
  still running. Once that expired and the controller is being torn down
  we have to use userspace interaction to get the connection back, which
  is not going to work with an all-paths-down scenario
- The infamous queue_if_no_path setting is missing. Currently we will
  hold on to every I/O until the connection is re-established, ie
  the equivalent of queue_if_no_path enabled with dm-multipath.
  However, for clustered environs we need to transport the I/O error
  back to the application so that the cluster can failover to another
  node.
- FC has a fast_io_fail_tmo, which allows the transport to terminate
  the I/O earlier; we need to check if a similar mechanism is required
  for nvme.

I would like to discuss how these points can be addressed to achieve
full parity with dm-multipathing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
