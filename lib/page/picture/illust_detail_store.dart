/*
 * Copyright (C) 2020. by perol_notsf, All rights reserved
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'package:mobx/mobx.dart';
import 'package:pixez/models/illust.dart';
import 'package:pixez/network/api_client.dart';

part 'illust_detail_store.g.dart';

class IllustDetailStore = _IllustDetailStoreBase with _$IllustDetailStore;

abstract class _IllustDetailStoreBase with Store {
  final Illusts illust;
  @observable
  bool isFollow;

  _IllustDetailStoreBase(this.illust) {
    isFollow = illust.user.isFollowed;
  }

  @action
  followUser() async {
    try {
      if (illust.user.isFollowed) {
        await apiClient.postUnFollowUser(illust.user.id);
        illust.user.isFollowed = false;
        isFollow = false;
      } else {
        await apiClient.postFollowUser(illust.user.id, 'public');
        illust.user.isFollowed = true;
        isFollow = true;
      }
    } catch (e) {}
  }
}
