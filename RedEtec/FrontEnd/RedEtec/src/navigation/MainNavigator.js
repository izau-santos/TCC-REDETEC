import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import TabNavigator from './TabNavigator';

export default function MainNavigator() {
    return (
        <NavigationContainer>
            <TabNavigator />
        </NavigationContainer>
    );
}