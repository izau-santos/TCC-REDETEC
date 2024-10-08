import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { MaterialCommunityIcons } from 'react-native-vector-icons';

import HomeScreen from '../pages/Home/HomeScreen';
import PostScreen from '../pages/Post/PostScreen';
import ChatScreen from '../pages/Chat/ChatScreen';
import ProfileScreen from '../pages/Profile/ProfileScreen';

const Tab = createBottomTabNavigator();

export default function TabNavigator() {
    return (
        <Tab.Navigator
            screenOptions={({ route }) => ({
                tabBarIcon: ({ color, size }) => {
                    let iconName;

                    switch (route.name) {
                        case 'Home':
                            iconName = 'home';
                            break;
                        case 'Post':
                            iconName = 'post';
                            break;
                        case 'Chat':
                            iconName = 'chat';
                            break;
                        case 'Profile':
                            iconName = 'account';
                            break;
                    }

                    return <MaterialCommunityIcons name={iconName} size={size} color={color} />;
                },
                tabBarActiveTintColor: '#040915',
                tabBarInactiveTintColor: '#8A8F9E',
            })}
        >
            <Tab.Screen
                name="Home"
                component={HomeScreen}
                options={{ headerShown: false }}
            />
            <Tab.Screen
                name="Post"
                component={PostScreen}
                options={{ headerShown: false }}
            />
            <Tab.Screen
                name="Chat"
                component={ChatScreen}
                options={{ headerShown: false }}
            />
            <Tab.Screen
                name="Profile"
                component={ProfileScreen}
                options={{ headerShown: false }}
            />
        </Tab.Navigator>
    );
}
